import 'package:dart_style/dart_style.dart';
import 'package:paraphrase/paraphrase.dart';
import 'package:testcase_gen/generator.dart';

abstract class DefaultGenerator implements Generator {
  const DefaultGenerator();

  GeneratorConfig? _getConfig(
      List<GeneratorConfig> configs, String methodName) {
    for (final config in configs) {
      if (config.name == methodName) {
        return config;
      }
    }
    return null;
  }

  String _concatParamName(String? prefix, String name) {
    if (prefix == null) return name;
    return '$prefix${name[0].toUpperCase()}${name.substring(1)}';
  }

  String _getParamType(Parameter parameter) {
    if (parameter.typeArguments.isEmpty) {
      return parameter.type;
    }

    return '${parameter.type}<${parameter.typeArguments.join(', ')}>';
  }

  void _createConstructorInitializerForMethodParameter(
    ParseResult parseResult,
    Parameter? rootParameter,
    Parameter parameter,
    StringBuffer initializerBuilder,
  ) {
    final bool isClass = parseResult.classMap.containsKey(parameter.type);
    final bool isEnum = parseResult.enumMap.containsKey(parameter.type);

    if (isEnum) {
      final enumz = parseResult.enumMap[parameter.type]!;

      initializerBuilder.writeln(
          'const ${_getParamType(parameter)} ${_concatParamName(rootParameter?.name, parameter.name)} = ${enumz.enumConstants[0].name};');

      return;
    }

    final parameterClass = parseResult.classMap[parameter.type]!;
    final initBlockParameterListBuilder = StringBuffer();
    final initBlockBuilder = StringBuffer();
    initBlockBuilder.write(parameterClass.name);
    initBlockBuilder.write('(');

    for (final cp in parameterClass.constructors[0].parameters) {
      final adjustedParamName = _concatParamName(parameter.name, cp.name);
      if (cp.isNamed) {
        if (cp.isPrimitiveType) {
          initBlockParameterListBuilder.writeln(
              'const ${_getParamType(cp)} $adjustedParamName = ${cp.primitiveDefualtValue()};');
          initBlockBuilder.write('${cp.name}: $adjustedParamName,');
        } else {
          _createConstructorInitializerForMethodParameter(
              parseResult, parameter, cp, initializerBuilder);
          initBlockBuilder.write('${cp.name}: $adjustedParamName,');
        }
      } else {
        if (cp.isPrimitiveType) {
          initBlockParameterListBuilder.writeln(
              'const ${_getParamType(cp)} $adjustedParamName = ${cp.primitiveDefualtValue()};');
          initBlockBuilder.write('$adjustedParamName,');
        } else {
          _createConstructorInitializerForMethodParameter(
              parseResult, parameter, cp, initializerBuilder);
          initBlockBuilder.write('$adjustedParamName,');
        }
      }
    }

    initBlockBuilder.write(')');

    initializerBuilder.write(initBlockParameterListBuilder.toString());
    initializerBuilder.writeln(
        'final ${_getParamType(parameter)} ${_concatParamName(rootParameter?.name, parameter.name)} = ${initBlockBuilder.toString()};');
  }

  String generateWithTemplate({
    required ParseResult parseResult,
    required Clazz clazz,
    required String testCaseTemplate,
    required String testCasesContentTemplate,
    required String methodInvokeObjectName,
    required List<GeneratorConfig> configs,
    List<GeneratorConfigPlatform>? supportedPlatformsOverride,
  }) {

    final testCases = <String>[];
    for (final method in clazz.methods) {
      final methodName = method.name;

      final config = _getConfig(configs, methodName);
      if (config?.donotGenerate == true) continue;
      if (methodName.startsWith('_')) continue;
      if (methodName.startsWith('create')) continue;

      StringBuffer pb = StringBuffer();


      for (final parameter in method.parameters) {
        if (parameter.isPrimitiveType) {
          pb.writeln(
              'const ${_getParamType(parameter)} ${parameter.name} = ${parameter.primitiveDefualtValue()};');
        } else {
          _createConstructorInitializerForMethodParameter(
              parseResult, null, parameter, pb);
        }
      }

      StringBuffer methodCallBuilder = StringBuffer();
      // methodCallBuilder.write('await screenShareHelper.$methodName(');
      methodCallBuilder.write('await $methodInvokeObjectName.$methodName(');
      for (final parameter in method.parameters) {
        if (parameter.isNamed) {
          methodCallBuilder.write('${parameter.name}:${parameter.name},');
        } else {
          methodCallBuilder.write('${parameter.name}, ');
        }
      }
      methodCallBuilder.write(');');

      pb.writeln(methodCallBuilder.toString());


      String skipExpression = 'false';

      if (supportedPlatformsOverride != null) {
        // skipExpression =
        //     '!(${desktopPlatforms.map((e) => e.toPlatformExpression()).join(' || ')})';
        skipExpression =
            '!(${supportedPlatformsOverride.map((e) => e.toPlatformExpression()).join(' || ')})';
      } else {
        if (config != null &&
            config.supportedPlatforms.length <
                GeneratorConfigPlatform.values.length) {
          skipExpression =
              '!(${config.supportedPlatforms.map((e) => e.toPlatformExpression()).join(' || ')})';
        }
      }

      String testCase =
          testCaseTemplate.replaceAll('{{TEST_CASE_NAME}}', methodName);
      testCase = testCase.replaceAll('{{TEST_CASE_BODY}}', pb.toString());
      testCase = testCase.replaceAll('{{TEST_CASE_SKIP}}', skipExpression);
      testCases.add(testCase);
    }


    final output = testCasesContentTemplate.replaceAll(
      '{{TEST_CASES_CONTENT}}',
      testCases.join('\n'),
    );

    return DartFormatter().format(output);
  }
}
