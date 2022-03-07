// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_handler_json.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScreenCaptureInfoJson _$ScreenCaptureInfoJsonFromJson(
        Map<String, dynamic> json) =>
    ScreenCaptureInfoJson(
      ScreenCaptureInfo.fromJson(json['info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ScreenCaptureInfoJsonToJson(
        ScreenCaptureInfoJson instance) =>
    <String, dynamic>{
      'info': instance.info,
    };

OnClientRoleChangeFailedJson _$OnClientRoleChangeFailedJsonFromJson(
        Map<String, dynamic> json) =>
    OnClientRoleChangeFailedJson(
      $enumDecode(_$ClientRoleChangeFailedReasonEnumMap, json['reason']),
      $enumDecode(_$ClientRoleEnumMap, json['currentRole']),
    );

Map<String, dynamic> _$OnClientRoleChangeFailedJsonToJson(
        OnClientRoleChangeFailedJson instance) =>
    <String, dynamic>{
      'reason': _$ClientRoleChangeFailedReasonEnumMap[instance.reason],
      'currentRole': _$ClientRoleEnumMap[instance.currentRole],
    };

const _$ClientRoleChangeFailedReasonEnumMap = {
  ClientRoleChangeFailedReason.TooManyBroadcasters: 1,
  ClientRoleChangeFailedReason.NotAuthorized: 2,
  ClientRoleChangeFailedReason.RequestTimeOut: 3,
  ClientRoleChangeFailedReason.ConnectionFailed: 4,
};

const _$ClientRoleEnumMap = {
  ClientRole.Broadcaster: 1,
  ClientRole.Audience: 2,
};

OnWlAccMessageJson _$OnWlAccMessageJsonFromJson(Map<String, dynamic> json) =>
    OnWlAccMessageJson(
      $enumDecode(_$WlaccMessageReasonEnumMap, json['reason']),
      $enumDecode(_$WlaccSuggestActionEnumMap, json['action']),
      json['wlAccMsg'] as String,
    );

Map<String, dynamic> _$OnWlAccMessageJsonToJson(OnWlAccMessageJson instance) =>
    <String, dynamic>{
      'reason': _$WlaccMessageReasonEnumMap[instance.reason],
      'action': _$WlaccSuggestActionEnumMap[instance.action],
      'wlAccMsg': instance.wlAccMsg,
    };

const _$WlaccMessageReasonEnumMap = {
  WlaccMessageReason.WeakSignal: 0,
  WlaccMessageReason.ChannelCongestion: 1,
};

const _$WlaccSuggestActionEnumMap = {
  WlaccSuggestAction.CloseToWifi: 0,
  WlaccSuggestAction.ConnectSsid: 1,
  WlaccSuggestAction.Check5g: 2,
  WlaccSuggestAction.ModifySsid: 3,
};

OnWlAccStatsJson _$OnWlAccStatsJsonFromJson(Map<String, dynamic> json) =>
    OnWlAccStatsJson(
      WlAccStats.fromJson(json['currentStats'] as Map<String, dynamic>),
      WlAccStats.fromJson(json['averageStats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OnWlAccStatsJsonToJson(OnWlAccStatsJson instance) =>
    <String, dynamic>{
      'currentStats': instance.currentStats,
      'averageStats': instance.averageStats,
    };

OnProxyConnectedJson _$OnProxyConnectedJsonFromJson(
        Map<String, dynamic> json) =>
    OnProxyConnectedJson(
      json['channel'] as String,
      json['uid'] as int,
      $enumDecode(_$ProxyTypeEnumMap, json['proxyType']),
      json['localProxyIp'] as String,
      json['elapsed'] as int,
    );

Map<String, dynamic> _$OnProxyConnectedJsonToJson(
        OnProxyConnectedJson instance) =>
    <String, dynamic>{
      'channel': instance.channel,
      'uid': instance.uid,
      'proxyType': _$ProxyTypeEnumMap[instance.proxyType],
      'localProxyIp': instance.localProxyIp,
      'elapsed': instance.elapsed,
    };

const _$ProxyTypeEnumMap = {
  ProxyType.None: 0,
  ProxyType.UDP: 1,
  ProxyType.TCP: 2,
  ProxyType.Local: 3,
  ProxyType.TCPProxyAutoFallbackType: 4,
};

OnAudioDeviceTestVolumeIndicationJson
    _$OnAudioDeviceTestVolumeIndicationJsonFromJson(
            Map<String, dynamic> json) =>
        OnAudioDeviceTestVolumeIndicationJson(
          $enumDecode(_$AudioDeviceTestVolumeTypeEnumMap, json['volumeType']),
          json['volume'] as int,
        );

Map<String, dynamic> _$OnAudioDeviceTestVolumeIndicationJsonToJson(
        OnAudioDeviceTestVolumeIndicationJson instance) =>
    <String, dynamic>{
      'volumeType': _$AudioDeviceTestVolumeTypeEnumMap[instance.volumeType],
      'volume': instance.volume,
    };

const _$AudioDeviceTestVolumeTypeEnumMap = {
  AudioDeviceTestVolumeType.AudioTestRecordingVolume: 0,
  AudioDeviceTestVolumeType.AudioTestPlaybackVolume: 1,
};
