// ignore_for_file: avoid_redundant_argument_values
/// Phase 10 — Failure-mode catalog proof tests.
///
/// Verifies that every failure code defined in [P2PFailureCode]:
///   (a) is a valid enum value,
///   (b) has a non-empty user-visible message key via [p2pFailureMessage],
///   (c) has a non-empty recovery hint key via [p2pFailureRecovery],
///   (d) has a defined [P2PFailureSeverity].
///
/// Tests are grouped by catalog section to match roadmap §10.0–§10.5.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:chessrecast/services/p2p/errors.dart';

void main() {
  // ─── helpers ──────────────────────────────────────────────────────────────

  void check(P2PFailureCode code) {
    final msg = p2pFailureMessage(code);
    expect(msg, isNotEmpty, reason: '${code.name} must have a message key');

    final recovery = p2pFailureRecovery(code);
    expect(
      recovery,
      isNotEmpty,
      reason: '${code.name} must have a recovery hint key',
    );

    final severity = p2pFailureSeverity(code);
    expect(severity, isA<P2PFailureSeverity>());
  }

  // ─── §10.0 base catalog ───────────────────────────────────────────────────

  group('§10.0 protocol codes (F-PROTO-001–008)', () {
    test('F-PROTO-001 badFrame', () => check(P2PFailureCode.badFrame));
    test('F-PROTO-002 badVersion', () => check(P2PFailureCode.badVersion));
    test(
      'F-PROTO-003 outOfSequence',
      () => check(P2PFailureCode.outOfSequence),
    );
    test(
      'F-PROTO-004 illegalMove',
      () => check(P2PFailureCode.illegalMove),
    );
    test(
      'F-PROTO-005 modMismatch',
      () => check(P2PFailureCode.modMismatch),
    );
    test(
      'F-PROTO-006 clockStarvation',
      () => check(P2PFailureCode.clockStarvation),
    );
    test(
      'F-PROTO-007 backpressureDrop',
      () => check(P2PFailureCode.backpressureDrop),
    );
    test('F-PROTO-008 mismatch', () => check(P2PFailureCode.mismatch));
  });

  group('§10.0 network codes (F-NET-001–007)', () {
    test('F-NET-001 iceFailed', () => check(P2PFailureCode.iceFailed));
    test(
      'F-NET-002 iceDisconnected',
      () => check(P2PFailureCode.iceDisconnected),
    );
    test(
      'F-NET-003 networkLost',
      () => check(P2PFailureCode.networkLost),
    );
    test(
      'F-NET-004 turnUnavailable',
      () => check(P2PFailureCode.turnUnavailable),
    );
    test(
      'F-NET-005 captivePortal',
      () => check(P2PFailureCode.captivePortal),
    );
    test(
      'F-NET-006 natHardBlock',
      () => check(P2PFailureCode.natHardBlock),
    );
    test(
      'F-NET-007 ipv6PmtuBlackHole',
      () => check(P2PFailureCode.ipv6PmtuBlackHole),
    );
  });

  group('§10.0 transport codes (F-XPORT-001–002)', () {
    test(
      'F-XPORT-001 datachannelClosedUnexpectedly',
      () => check(P2PFailureCode.datachannelClosedUnexpectedly),
    );
    test(
      'F-XPORT-002 sctpHandshakeTimeout',
      () => check(P2PFailureCode.sctpHandshakeTimeout),
    );
  });

  group('§10.0 signaling codes (F-SIG-001–006)', () {
    test(
      'F-SIG-001 signaling5xx',
      () => check(P2PFailureCode.signaling5xx),
    );
    test(
      'F-SIG-002 signalingRateLimited',
      () => check(P2PFailureCode.signalingRateLimited),
    );
    test(
      'F-SIG-003 signalingPowRequired',
      () => check(P2PFailureCode.signalingPowRequired),
    );
    test(
      'F-SIG-004 offerExpired',
      () => check(P2PFailureCode.offerExpired),
    );
    test(
      'F-SIG-005 offerDuplicateAnswer',
      () => check(P2PFailureCode.offerDuplicateAnswer),
    );
    test(
      'F-SIG-006 adminDisabled',
      () => check(P2PFailureCode.adminDisabled),
    );
  });

  group('§10.0 identity codes (F-ID-001–007)', () {
    test(
      'F-ID-001 keyGenFailed',
      () => check(P2PFailureCode.keyGenFailed),
    );
    test(
      'F-ID-002 keyStorageUnavailable',
      () => check(P2PFailureCode.keyStorageUnavailable),
    );
    test(
      'F-ID-003 biometricLockout',
      () => check(P2PFailureCode.biometricLockout),
    );
    test(
      'F-ID-004 recoveryBadCode',
      () => check(P2PFailureCode.recoveryBadCode),
    );
    test(
      'F-ID-005 recoveryParamMismatch',
      () => check(P2PFailureCode.recoveryParamMismatch),
    );
    test(
      'F-ID-006 rebindAttestationFailed',
      () => check(P2PFailureCode.rebindAttestationFailed),
    );
    test(
      'F-ID-007 oldDeviceRejectedAfterRebind',
      () => check(P2PFailureCode.oldDeviceRejectedAfterRebind),
    );
  });

  group('§10.0 push codes (F-PUSH-001–004)', () {
    test(
      'F-PUSH-001 pushTokenInvalid',
      () => check(P2PFailureCode.pushTokenInvalid),
    );
    test(
      'F-PUSH-002 pushProviderDown',
      () => check(P2PFailureCode.pushProviderDown),
    );
    test(
      'F-PUSH-003 pushDeferredByOs',
      () => check(P2PFailureCode.pushDeferredByOs),
    );
    test(
      'F-PUSH-004 pushReceivedNoOffer',
      () => check(P2PFailureCode.pushReceivedNoOffer),
    );
  });

  group('§10.0 lifecycle codes (F-LIFECYCLE-001–004)', () {
    test(
      'F-LIFECYCLE-001 appSuspendedMidHandshake',
      () => check(P2PFailureCode.appSuspendedMidHandshake),
    );
    test(
      'F-LIFECYCLE-002 foregroundServiceKilled',
      () => check(P2PFailureCode.foregroundServiceKilled),
    );
    test(
      'F-LIFECYCLE-003 iosNseTimeout',
      () => check(P2PFailureCode.iosNseTimeout),
    );
    test(
      'F-LIFECYCLE-004 deepLinkColdStartLost',
      () => check(P2PFailureCode.deepLinkColdStartLost),
    );
  });

  group('§10.0 storage codes (F-STORE-001–003)', () {
    test(
      'F-STORE-001 savedGamesDbCorrupt',
      () => check(P2PFailureCode.savedGamesDbCorrupt),
    );
    test(
      'F-STORE-002 savedGamesMigrationFailed',
      () => check(P2PFailureCode.savedGamesMigrationFailed),
    );
    test('F-STORE-003 diskFull', () => check(P2PFailureCode.diskFull));
  });

  group('§10.0 web/desktop/observability/chat/misc codes', () {
    test(
      'F-WEB-001 webrtcNotSupported',
      () => check(P2PFailureCode.webrtcNotSupported),
    );
    test(
      'F-WEB-002 webcryptoNonExtractableLimit',
      () => check(P2PFailureCode.webcryptoNonExtractableLimit),
    );
    test(
      'F-DESKTOP-001 libsecretUnavailable',
      () => check(P2PFailureCode.libsecretUnavailable),
    );
    test(
      'F-OBS-001 telemetryQueueOverflow',
      () => check(P2PFailureCode.telemetryQueueOverflow),
    );
    test(
      'F-CHAT-001 chatFrameTooLarge',
      () => check(P2PFailureCode.chatFrameTooLarge),
    );
    test(
      'F-CHAT-002 chatRateLimitLocal',
      () => check(P2PFailureCode.chatRateLimitLocal),
    );
    test(
      'F-LATEJOIN-001 lamportConflict',
      () => check(P2PFailureCode.lamportConflict),
    );
    test(
      'F-FORENSIC-001 forensicBundleWriteFailed',
      () => check(P2PFailureCode.forensicBundleWriteFailed),
    );
  });

  // ─── §10.1 v5 additions ───────────────────────────────────────────────────

  group('§10.1 v5 protocol codes (F-PROTO-009–015)', () {
    test(
      'F-PROTO-009 wireVersionMismatch',
      () => check(P2PFailureCode.wireVersionMismatch),
    );
    test(
      'F-PROTO-010 engineVersionMismatch',
      () => check(P2PFailureCode.engineVersionMismatch),
    );
    test(
      'F-PROTO-011 modConfigRejected',
      () => check(P2PFailureCode.modConfigRejected),
    );
    test(
      'F-PROTO-012 timeControlRejected',
      () => check(P2PFailureCode.timeControlRejected),
    );
    test(
      'F-PROTO-013 colorFlipRevealMismatch',
      () => check(P2PFailureCode.colorFlipRevealMismatch),
    );
    test(
      'F-PROTO-014 transcriptSignFailed',
      () => check(P2PFailureCode.transcriptSignFailed),
    );
    test(
      'F-PROTO-015 byeDisagreement',
      () => check(P2PFailureCode.byeDisagreement),
    );
  });

  group('§10.1 v5 clock codes (F-CLOCK-001–003)', () {
    test(
      'F-CLOCK-001 clockDesyncBeyondBudget',
      () => check(P2PFailureCode.clockDesyncBeyondBudget),
    );
    test(
      'F-CLOCK-002 flagFallDisagreement',
      () => check(P2PFailureCode.flagFallDisagreement),
    );
    test(
      'F-CLOCK-003 resyncTimeout',
      () => check(P2PFailureCode.resyncTimeout),
    );
  });

  group('§10.1 v5 misc codes', () {
    test(
      'F-XPORT-003 perfectNegCollisionUnresolved',
      () => check(P2PFailureCode.perfectNegCollisionUnresolved),
    );
    test(
      'F-SIG-007 offerTokenExpired',
      () => check(P2PFailureCode.offerTokenExpired),
    );
    test(
      'F-SIG-008 readOnlyModeRejectedWrite',
      () => check(P2PFailureCode.readOnlyModeRejectedWrite),
    );
    test(
      'F-SIG-009 rebindRaceLost',
      () => check(P2PFailureCode.rebindRaceLost),
    );
    test(
      'F-ID-008 kdfVersionUnsupported',
      () => check(P2PFailureCode.kdfVersionUnsupported),
    );
    test(
      'F-ID-009 bip39ChecksumFail',
      () => check(P2PFailureCode.bip39ChecksumFail),
    );
    test(
      'F-ID-010 kdfParamsTooWeak',
      () => check(P2PFailureCode.kdfParamsTooWeak),
    );
    test(
      'F-ID-011 xchaChaNonceReuseDetected',
      () => check(P2PFailureCode.xchaChaNonceReuseDetected),
    );
    test(
      'F-INTEGRITY-001 startupIntegrityFail',
      () => check(P2PFailureCode.startupIntegrityFail),
    );
    test(
      'F-WEB-003 webPlatformUnsupportedFeature',
      () => check(P2PFailureCode.webPlatformUnsupportedFeature),
    );
    test(
      'F-DESKTOP-002 biometricNotAvailableDesktop',
      () => check(P2PFailureCode.biometricNotAvailableDesktop),
    );
    test(
      'F-OBS-002 diagLogDiskFull',
      () => check(P2PFailureCode.diagLogDiskFull),
    );
    test(
      'F-OPS-001 killSwitchEngaged',
      () => check(P2PFailureCode.killSwitchEngaged),
    );
  });

  // ─── §10.2 v6 additions ───────────────────────────────────────────────────

  group('§10.2 v6 protocol codes (F-PROTO-016–022)', () {
    test(
      'F-PROTO-016 seqCeilingReached',
      () => check(P2PFailureCode.seqCeilingReached),
    );
    test(
      'F-PROTO-017 byeFragmentTimeout',
      () => check(P2PFailureCode.byeFragmentTimeout),
    );
    test(
      'F-PROTO-018 byeFragmentOutOfOrder',
      () => check(P2PFailureCode.byeFragmentOutOfOrder),
    );
    test(
      'F-PROTO-019 byeFragmentOutOfBounds',
      () => check(P2PFailureCode.byeFragmentOutOfBounds),
    );
    test(
      'F-PROTO-020 fragmentNotAllowed',
      () => check(P2PFailureCode.fragmentNotAllowed),
    );
    test(
      'F-PROTO-021 cryptoSuiteNotNegotiated',
      () => check(P2PFailureCode.cryptoSuiteNotNegotiated),
    );
    test(
      'F-PROTO-022 transcriptVersionUnsupported',
      () => check(P2PFailureCode.transcriptVersionUnsupported),
    );
  });

  group('§10.2 v6 misc codes', () {
    test(
      'F-ID-012 kdfDerivationFailed',
      () => check(P2PFailureCode.kdfDerivationFailed),
    );
    test(
      'F-ID-013 secretZeroiseFailed',
      () => check(P2PFailureCode.secretZeroiseFailed),
    );
    test(
      'F-XPORT-004 datachannelIdCollision',
      () => check(P2PFailureCode.datachannelIdCollision),
    );
    test(
      'F-XPORT-005 resumedAsNew',
      () => check(P2PFailureCode.resumedAsNew),
    );
    test(
      'F-CLOCK-004 monotonicClockUnavailable',
      () => check(P2PFailureCode.monotonicClockUnavailable),
    );
    test(
      'F-CLOCK-005 wallClockTamperedDetected',
      () => check(P2PFailureCode.wallClockTamperedDetected),
    );
    test(
      'F-NET-008 meteredNetworkUserDeclined',
      () => check(P2PFailureCode.meteredNetworkUserDeclined),
    );
    test(
      'F-LIFECYCLE-005 oemBatteryOptBlocking',
      () => check(P2PFailureCode.oemBatteryOptBlocking),
    );
    test(
      'F-PUSH-005 apnsSilentPushDropped',
      () => check(P2PFailureCode.apnsSilentPushDropped),
    );
    test(
      'F-PUSH-006 fcmTokenRefreshed',
      () => check(P2PFailureCode.fcmTokenRefreshed),
    );
    test(
      'F-ID-014 recoveryScreenCapturedDetected',
      () => check(P2PFailureCode.recoveryScreenCapturedDetected),
    );
    test(
      'F-CHAT-003 chatBlockedByUser',
      () => check(P2PFailureCode.chatBlockedByUser),
    );
    test(
      'F-CHAT-004 chatReportedAsAbuse',
      () => check(P2PFailureCode.chatReportedAsAbuse),
    );
    test(
      'F-ONBOARD-001 ageGateBlocked',
      () => check(P2PFailureCode.ageGateBlocked),
    );
    test(
      'F-STORE-004 storePrivacyManifestOutOfDate',
      () => check(P2PFailureCode.storePrivacyManifestOutOfDate),
    );
    test(
      'F-SIG-010 deviceCapExceeded',
      () => check(P2PFailureCode.deviceCapExceeded),
    );
    test(
      'F-SIG-011 longPollCapExceeded',
      () => check(P2PFailureCode.longPollCapExceeded),
    );
    test(
      'F-SIG-012 sdpTooLarge',
      () => check(P2PFailureCode.sdpTooLarge),
    );
    test(
      'F-SIG-013 sdpForbiddenMediaLine',
      () => check(P2PFailureCode.sdpForbiddenMediaLine),
    );
    test(
      'F-SPEC-001 spectatorChainRejected',
      () => check(P2PFailureCode.spectatorChainRejected),
    );
    test(
      'F-CONC-001 isolateCrashed',
      () => check(P2PFailureCode.isolateCrashed),
    );
    test(
      'F-CONC-002 sodiumInitFailed',
      () => check(P2PFailureCode.sodiumInitFailed),
    );
  });

  // ─── §10.3 v7 additions ───────────────────────────────────────────────────

  group('§10.3 v7 storage codes (F-STORE-005–008)', () {
    test(
      'F-STORE-005 sqlcipherKeyUnwrapFail',
      () => check(P2PFailureCode.sqlcipherKeyUnwrapFail),
    );
    test(
      'F-STORE-006 localStorageQuotaExceeded',
      () => check(P2PFailureCode.localStorageQuotaExceeded),
    );
    test(
      'F-STORE-007 localStorageAtRestBroken',
      () => check(P2PFailureCode.localStorageAtRestBroken),
    );
    test(
      'F-STORE-008 backupEncryptionSaltMismatch',
      () => check(P2PFailureCode.backupEncryptionSaltMismatch),
    );
  });

  group('§10.3 v7 identity codes (F-ID-015–018)', () {
    test(
      'F-ID-015 kciVerifyFailed',
      () => check(P2PFailureCode.kciVerifyFailed),
    );
    test(
      'F-ID-016 sessionIdCollision',
      () => check(P2PFailureCode.sessionIdCollision),
    );
    test(
      'F-ID-017 safetyNumbersMismatch',
      () => check(P2PFailureCode.safetyNumbersMismatch),
    );
    test(
      'F-ID-018 reKeyFailed',
      () => check(P2PFailureCode.reKeyFailed),
    );
  });

  group('§10.3 v7 protocol codes (F-PROTO-023–029)', () {
    test(
      'F-PROTO-023 cborFloatRejected',
      () => check(P2PFailureCode.cborFloatRejected),
    );
    test(
      'F-PROTO-024 hkdfInfoUnknown',
      () => check(P2PFailureCode.hkdfInfoUnknown),
    );
    test(
      'F-PROTO-025 opponentFingerprintDowngradeDetected',
      () => check(P2PFailureCode.opponentFingerprintDowngradeDetected),
    );
    test(
      'F-PROTO-026 repetitionClaimRejected',
      () => check(P2PFailureCode.repetitionClaimRejected),
    );
    test(
      'F-PROTO-027 deprecatedWireVersionRejected',
      () => check(P2PFailureCode.deprecatedWireVersionRejected),
    );
    test(
      'F-PROTO-028 deprecatedCryptoSuiteRejected',
      () => check(P2PFailureCode.deprecatedCryptoSuiteRejected),
    );
    test(
      'F-PROTO-029 deprecatedEngineReplayVersionRejected',
      () => check(P2PFailureCode.deprecatedEngineReplayVersionRejected),
    );
  });

  group('§10.3 v7 misc codes', () {
    test(
      'F-NET-009 turnsHandshakeFailed',
      () => check(P2PFailureCode.turnsHandshakeFailed),
    );
    test(
      'F-CLOCK-006 premoveInvalidated',
      () => check(P2PFailureCode.premoveInvalidated),
    );
    test(
      'F-SIG-014 inviteLinkExpired',
      () => check(P2PFailureCode.inviteLinkExpired),
    );
    test(
      'F-SIG-015 inviteLinkReplayed',
      () => check(P2PFailureCode.inviteLinkReplayed),
    );
    test(
      'F-CHAT-005 handleImpersonationSuspected',
      () => check(P2PFailureCode.handleImpersonationSuspected),
    );
    test(
      'F-OBS-003 transcriptRamCapOverflow',
      () => check(P2PFailureCode.transcriptRamCapOverflow),
    );
    test(
      'F-OPS-002 cveRequiresForcedUpdate',
      () => check(P2PFailureCode.cveRequiresForcedUpdate),
    );
    test(
      'F-OPS-003 keyRotationOverdue',
      () => check(P2PFailureCode.keyRotationOverdue),
    );
    test(
      'F-OPS-004 backupRestoreDrillFailed',
      () => check(P2PFailureCode.backupRestoreDrillFailed),
    );
    test(
      'F-OPS-005 operatorOnCallUnreachable',
      () => check(P2PFailureCode.operatorOnCallUnreachable),
    );
  });

  // ─── §10.4 v8 additions ───────────────────────────────────────────────────

  group('§10.4 v8 protocol codes (F-PROTO-030–037)', () {
    test(
      'F-PROTO-030 validateApplyRaceDetected',
      () => check(P2PFailureCode.validateApplyRaceDetected),
    );
    test(
      'F-PROTO-031 ffiFuzzFoundDivergence',
      () => check(P2PFailureCode.ffiFuzzFoundDivergence),
    );
    test(
      'F-PROTO-032 helloTsOutOfWindow',
      () => check(P2PFailureCode.helloTsOutOfWindow),
    );
    test(
      'F-PROTO-033 signedTimeFetchFailed',
      () => check(P2PFailureCode.signedTimeFetchFailed),
    );
    test(
      'F-PROTO-034 multiDeviceRaceLost',
      () => check(P2PFailureCode.multiDeviceRaceLost),
    );
    test(
      'F-PROTO-035 configBlobVersionUnsupported',
      () => check(P2PFailureCode.configBlobVersionUnsupported),
    );
    test(
      'F-PROTO-036 spectatorChainDepthNonzeroRejected',
      () => check(P2PFailureCode.spectatorChainDepthNonzeroRejected),
    );
    test(
      'F-PROTO-037 backfillOversizeRejected',
      () => check(P2PFailureCode.backfillOversizeRejected),
    );
  });

  group('§10.4 v8 misc codes', () {
    test(
      'F-START-001 startupSelfTestFail',
      () => check(P2PFailureCode.startupSelfTestFail),
    );
    test(
      'F-START-002 nativeLibIntegrityFail',
      () => check(P2PFailureCode.nativeLibIntegrityFail),
    );
    test(
      'F-PUSH-007 pushCoalesced',
      () => check(P2PFailureCode.pushCoalesced),
    );
    test(
      'F-NET-010 turnBandwidthExceeded',
      () => check(P2PFailureCode.turnBandwidthExceeded),
    );
    test(
      'F-NET-011 iceVpnLeakUserDeclined',
      () => check(P2PFailureCode.iceVpnLeakUserDeclined),
    );
    test(
      'F-STORE-009 schemaSkipVersionFail',
      () => check(P2PFailureCode.schemaSkipVersionFail),
    );
    test(
      'F-TEL-001 dpBudgetExceeded',
      () => check(P2PFailureCode.dpBudgetExceeded),
    );
    test(
      'F-TEL-002 telemetryEnvelopeVersionUnsupported',
      () => check(P2PFailureCode.telemetryEnvelopeVersionUnsupported),
    );
    test(
      'F-STUDY-001 studyLoadVersionMismatch',
      () => check(P2PFailureCode.studyLoadVersionMismatch),
    );
    test(
      'F-STUDY-002 exportSidecarMissing',
      () => check(P2PFailureCode.exportSidecarMissing),
    );
    test(
      'F-STUDY-003 studyPgnParseFail',
      () => check(P2PFailureCode.studyPgnParseFail),
    );
    test(
      'F-STUDY-004 studyReplayHashDivergence',
      () => check(P2PFailureCode.studyReplayHashDivergence),
    );
    test(
      'F-LIFE-005 bgTaskDeniedByOs',
      () => check(P2PFailureCode.bgTaskDeniedByOs),
    );
    test(
      'F-NET-012 loadShedDropped',
      () => check(P2PFailureCode.loadShedDropped),
    );
    test(
      'F-CLOCK-007 rageQuitForfeitFired',
      () => check(P2PFailureCode.rageQuitForfeitFired),
    );
    test(
      'F-STORE-010 legitimateRestoreMergeDeclined',
      () => check(P2PFailureCode.legitimateRestoreMergeDeclined),
    );
    test(
      'F-CHAT-006v8 reportTargetRateLimited',
      () => check(P2PFailureCode.reportTargetRateLimited),
    );
  });

  // ─── §10.5 v9 additions (spectator + chat) ────────────────────────────────

  group('§10.5 v9 spectator codes (F-SPEC-001–014)', () {
    test(
      'F-SPEC-002 spectatorCapacityFull',
      () => check(P2PFailureCode.spectatorCapacityFull),
    );
    test(
      'F-SPEC-003 spectatorWaitlistExpired',
      () => check(P2PFailureCode.spectatorWaitlistExpired),
    );
    test(
      'F-SPEC-004 spectatorAuthRequired',
      () => check(P2PFailureCode.spectatorAuthRequired),
    );
    test(
      'F-SPEC-005 spectatorJoinRateLimited',
      () => check(P2PFailureCode.spectatorJoinRateLimited),
    );
    test(
      'F-SPEC-006 spectatorKicked',
      () => check(P2PFailureCode.spectatorKicked),
    );
    test(
      'F-SPEC-007 spectatorBanned',
      () => check(P2PFailureCode.spectatorBanned),
    );
    test(
      'F-SPEC-008 spectatorMuted',
      () => check(P2PFailureCode.spectatorMuted),
    );
    test(
      'F-SPEC-009 spectatorGloballyMuted',
      () => check(P2PFailureCode.spectatorGloballyMuted),
    );
    test(
      'F-SPEC-010 spectatorShedForPerf',
      () => check(P2PFailureCode.spectatorShedForPerf),
    );
    test(
      'F-SPEC-011 spectatorRelayUnavailable',
      () => check(P2PFailureCode.spectatorRelayUnavailable),
    );
    test(
      'F-SPEC-012 backfillQueueOverflow',
      () => check(P2PFailureCode.backfillQueueOverflow),
    );
    test(
      'F-SPEC-013 spectatorHeartbeatTimeout',
      () => check(P2PFailureCode.spectatorHeartbeatTimeout),
    );
    test(
      'F-SPEC-014 spectatorKeyRotationRequired',
      () => check(P2PFailureCode.spectatorKeyRotationRequired),
    );
    test(
      'F-SPEC-015 spectatorDatachannelBackpressure',
      () => check(P2PFailureCode.spectatorDatachannelBackpressure),
    );
  });

  group('§10.5 v9 chat codes (F-CHAT-007–020)', () {
    test(
      'F-CHAT-007 chatRateLimited',
      () => check(P2PFailureCode.chatRateLimited),
    );
    test(
      'F-CHAT-008 chatMessageOversized',
      () => check(P2PFailureCode.chatMessageOversized),
    );
    test(
      'F-CHAT-009 chatSlowModeActive',
      () => check(P2PFailureCode.chatSlowModeActive),
    );
    test(
      'F-CHAT-010 chatAutoThrottledClockPressure',
      () => check(P2PFailureCode.chatAutoThrottledClockPressure),
    );
    test(
      'F-CHAT-011 chatReceiverOverflow',
      () => check(P2PFailureCode.chatReceiverOverflow),
    );
    test(
      'F-CHAT-012 chatReportFiled',
      () => check(P2PFailureCode.chatReportFiled),
    );
    test(
      'F-CHAT-013 chatTournamentLocked',
      () => check(P2PFailureCode.chatTournamentLocked),
    );
    test(
      'F-CHAT-014 chatHostBroadcastDroppedLowPriority',
      () => check(P2PFailureCode.chatHostBroadcastDroppedLowPriority),
    );
    test(
      'F-CHAT-015 chatDecodeErrorDiscarded',
      () => check(P2PFailureCode.chatDecodeErrorDiscarded),
    );
    test(
      'F-CHAT-016 chatNfcNormalisationFail',
      () => check(P2PFailureCode.chatNfcNormalisationFail),
    );
    test(
      'F-CHAT-017 chatHomoglyphBlocked',
      () => check(P2PFailureCode.chatHomoglyphBlocked),
    );
  });

  // ─── cross-cutting: severity contract ─────────────────────────────────────

  group('severity contract', () {
    test('critical codes have severity critical', () {
      final critical = [
        P2PFailureCode.secretZeroiseFailed,
        P2PFailureCode.xchaChaNonceReuseDetected,
        P2PFailureCode.sessionIdCollision,
        P2PFailureCode.validateApplyRaceDetected,
        P2PFailureCode.sodiumInitFailed,
      ];
      for (final code in critical) {
        expect(
          p2pFailureSeverity(code),
          equals(P2PFailureSeverity.critical),
          reason: '${code.name} must be severity=critical',
        );
      }
    });

    test('informational codes have severity info', () {
      final info = [
        P2PFailureCode.fcmTokenRefreshed,
        P2PFailureCode.pushCoalesced,
        P2PFailureCode.wallClockTamperedDetected,
        P2PFailureCode.premoveInvalidated,
      ];
      for (final code in info) {
        expect(
          p2pFailureSeverity(code),
          equals(P2PFailureSeverity.info),
          reason: '${code.name} must be severity=info',
        );
      }
    });
  });

  // ─── completeness: every value covered ────────────────────────────────────

  group('completeness', () {
    test('all enum values have non-empty message and recovery keys', () {
      for (final code in P2PFailureCode.values) {
        final msg = p2pFailureMessage(code);
        expect(msg, isNotEmpty, reason: '${code.name} missing message key');
        final rec = p2pFailureRecovery(code);
        expect(rec, isNotEmpty, reason: '${code.name} missing recovery key');
      }
    });
  });
}
