/*
 * Author: SilentSpike
 * Set the cargo space of any object, only affects the local machine unless specified.
 * Adds the cargo action menu if necessary.
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Cargo space <NUMBER> (Default: 1)
 * 2: Apply globally <BOOL> (Default: false)
 *
 * Return Value:
 * None
 *
 * Example:
 * [vehicle player, 20, true] call ace_cargo_fnc_setSpace
 *
 * Public: Yes
 */
#include "script_component.hpp"

// Only run this after the settings are initialized
if !(EGVAR(common,settingsInitFinished)) exitWith {
    EGVAR(common,runAtSettingsInitialized) pushBack [FUNC(setSpace), _this];
};

params [
    ["_vehicle",objNull,[objNull]],
    ["_space",nil,[0]], // Default can't be a number since all are valid
    ["_global",false,[true]]
];

if (isNull _vehicle) exitWith {};

// Space matters
private _currentSpace = _vehicle getVariable [QGVAR(space), getNumber (configFile >> "CfgVehicles" >> typeOf _vehicle >> QGVAR(space))];
if (isNil "_space") then {
    _space = _currentSpace;
};

// If specified, apply new space on all machines
if (_space != _currentSpace) then {
    _vehicle setVariable [QGVAR(space), _space, _global];
    _vehicle setVariable [QGVAR(hasCargo), _space > 0, _global];
};

// Add the load action menu if necessary
[_vehicle] call FUNC(initVehicle);

// And globally is specified
if (_global) then {
    [QGVAR(initVehicle), [_vehicle]] call CBA_fnc_remoteEvent;
};
