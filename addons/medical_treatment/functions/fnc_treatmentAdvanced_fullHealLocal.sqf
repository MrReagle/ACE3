/**
 * fn_healLocal.sqf
 * @Descr: N/A
 * @Author: Glowbal
 *
 * @Arguments: []
 * @Return:
 * @PublicAPI: false
 */

#include "script_component.hpp"

params ["_caller", "_target"];

if (alive _target) exitWith {

    _target setVariable [QEGVAR(medical,pain), 0, true];
    _target setVariable [QEGVAR(medical,morphine), 0, true];
    _target setVariable [QEGVAR(medical,bloodVolume), 100, true];

    // tourniquets
    _target setVariable [QEGVAR(medical,tourniquets), [0,0,0,0,0,0], true];

    // wounds and injuries
    _target setVariable [QEGVAR(medical,openWounds), [], true];
    _target setVariable [QEGVAR(medical,bandagedWounds), [], true];
    _target setVariable [QEGVAR(medical,internalWounds), [], true];

    // vitals
    _target setVariable [QEGVAR(medical,heartRate), 80];
    _target setVariable [QEGVAR(medical,heartRateAdjustments), []];
    _target setVariable [QEGVAR(medical,bloodPressure), [80, 120]];
    _target setVariable [QEGVAR(medical,peripheralResistance), 100];

    // fractures
    _target setVariable [QEGVAR(medical,fractures), []];

    // IVs
    _target setVariable [QEGVAR(medical,ivBags), nil, true];

    // damage storage
    _target setVariable [QEGVAR(medical,bodyPartStatus), [0,0,0,0,0,0], true];

    // airway
    _target setVariable [QEGVAR(medical,airwayStatus), 100, true];
    _target setVariable [QEGVAR(medical,airwayOccluded), false, true];
    _target setVariable [QEGVAR(medical,airwayCollapsed), false, true];

    // generic medical admin
    _target setVariable [QEGVAR(medical,addedToUnitLoop), false, true];
    _target setVariable [QEGVAR(medical,inCardiacArrest), false, true];
    _target setVariable [QEGVAR(medical,inReviveState), false, true];
    _target setVariable ["ACE_isUnconscious", false, true];
    _target setVariable [QEGVAR(medical,hasLostBlood), 0, true];
    _target setVariable [QEGVAR(medical,isBleeding), false, true];
    _target setVariable [QEGVAR(medical,hasPain), false, true];
    _target setVariable [QEGVAR(medical,painSuppress), 0, true];

    // medication
    private _allUsedMedication = _target getVariable [QEGVAR(medical,allUsedMedication), []];
    {
       _target setVariable [_x select 0, nil];
    } forEach _allUsedMedication;

    // Resetting damage
    _target setDamage 0;

    [_target, "activity", LSTRING(Activity_fullHeal), [[_caller, false, true] call EFUNC(common,getName)]] call FUNC(addToLog);
    [_target, "activity_view", LSTRING(Activity_fullHeal), [[_caller, false, true] call EFUNC(common,getName)]] call FUNC(addToLog); // TODO expand message
};