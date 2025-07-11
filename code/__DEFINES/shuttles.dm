//shuttle mode defines
#define SHUTTLE_IDLE "idle"
#define SHUTTLE_IGNITING "igniting"
#define SHUTTLE_RECALL "recalled"
#define SHUTTLE_CALL "called"
#define SHUTTLE_DOCKED "docked"
#define SHUTTLE_STRANDED "stranded"
#define SHUTTLE_ESCAPE "escape"
#define SHUTTLE_ENDGAME "endgame: game over"
#define SHUTTLE_RECHARGING "recharging"
#define SHUTTLE_PREARRIVAL "pre-arrival"

#define EMERGENCY_IDLE_OR_RECALLED (SSshuttle.emergency && ((SSshuttle.emergency.mode == SHUTTLE_IDLE) || (SSshuttle.emergency.mode == SHUTTLE_RECALL)))
#define EMERGENCY_ESCAPED_OR_ENDGAMED (SSshuttle.emergency && ((SSshuttle.emergency.mode == SHUTTLE_ESCAPE) || (SSshuttle.emergency.mode == SHUTTLE_ENDGAME)))
#define EMERGENCY_AT_LEAST_DOCKED (SSshuttle.emergency && SSshuttle.emergency.mode != SHUTTLE_IDLE && SSshuttle.emergency.mode != SHUTTLE_RECALL && SSshuttle.emergency.mode != SHUTTLE_CALL)

// Shuttle return values
#define SHUTTLE_CAN_DOCK "can_dock"
#define SHUTTLE_NOT_A_DOCKING_PORT "not a docking port"
#define SHUTTLE_DWIDTH_TOO_LARGE "docking width too large"
#define SHUTTLE_WIDTH_TOO_LARGE "width too large"
#define SHUTTLE_DHEIGHT_TOO_LARGE "docking height too large"
#define SHUTTLE_HEIGHT_TOO_LARGE "height too large"
#define SHUTTLE_RESERVED "dock is reserved"
#define SHUTTLE_ALREADY_DOCKED "we are already docked"
#define SHUTTLE_SOMEONE_ELSE_DOCKED "someone else docked"

//Launching Shuttles to CentCom
#define NOLAUNCH -1
#define UNLAUNCHED 0
#define ENDGAME_LAUNCHED 1
#define EARLY_LAUNCHED 2
#define ENDGAME_TRANSIT 3

/// shuttle is immune to gamemode timer restrictions
#define GAMEMODE_IMMUNE (1<<0)

// Ripples, effects that signal a shuttle's arrival
#define SHUTTLE_RIPPLE_TIME 100

#define TRANSIT_REQUEST 1
#define TRANSIT_READY 2

#define SHUTTLE_TRANSIT_BORDER 8

#define PARALLAX_LOOP_TIME 25
#define HYPERSPACE_END_TIME 5

#define HYPERSPACE_WARMUP 1
#define HYPERSPACE_LAUNCH 2
#define HYPERSPACE_END 3

#define CALL_SHUTTLE_REASON_LENGTH 12

//Engine related
#define ENGINE_COEFF_MIN 0.5
#define ENGINE_COEFF_MAX 2
#define ENGINE_DEFAULT_MAXSPEED_ENGINES 5

//Docking error flags
#define DOCKING_SUCCESS 0
#define DOCKING_BLOCKED (1<<0)
#define DOCKING_IMMOBILIZED (1<<1)
#define DOCKING_AREA_EMPTY (1<<2)
#define DOCKING_NULL_DESTINATION (1<<3)
#define DOCKING_NULL_SOURCE (1<<4)

//Docking turf movements
#define MOVE_TURF 1
#define MOVE_AREA 2
#define MOVE_CONTENTS 4

//Rotation params
#define ROTATE_DIR 1
#define ROTATE_SMOOTH 2
#define ROTATE_OFFSET 4

#define SHUTTLE_DOCKER_LANDING_CLEAR 1
#define SHUTTLE_DOCKER_BLOCKED_BY_HIDDEN_PORT 2
#define SHUTTLE_DOCKER_BLOCKED 3

//Shuttle defaults
#define SHUTTLE_DEFAULT_SHUTTLE_AREA_TYPE /area/shuttle
#define SHUTTLE_DEFAULT_UNDERLYING_AREA /area/space

//Shuttle flying state
#define SHUTTLE_ON_SHIP "on ship"
#define SHUTTLE_IN_SPACE "in space"
#define SHUTTLE_IN_ATMOSPHERE "in atmosphere"
#define SHUTTLE_ON_GROUND "on ground"

//Call time of shuttle
#define SHUTTLE_LANDING_CALLTIME 0 SECONDS
#define SHUTTLE_TAKEOFF_SHIP_CALLTIME 10 SECONDS
#define SHUTTLE_TAKEOFF_GROUND_CALLTIME 2 SECONDS

//Shuttle control flags
#define SHUTTLE_MARINE_PRIMARY_DROPSHIP (1<<0)

//Shuttle name defines used for a whole load of stuff
#define SHUTTLE_ALAMO "alamo"
#define SHUTTLE_NORMANDY "normandy"
#define SHUTTLE_TADPOLE "minidropship"
#define SHUTTLE_CLFTADPOLE "minidropshipclf"
#define SHUTTLE_SOMTADPOLE "minidropshipsom"
#define SHUTTLE_CANTERBURY "tgs_canterbury"
#define SHUTTLE_CAS "casplane"
#define SHUTTLE_CAS_DOCK "cas_dock"
#define SHUTTLE_BIGBURY "tgs_bigbury"
#define SHUTTLE_ESCAPE_SHUTTLE "escape_shuttle"
#define SHUTTLE_BIG_ERT "big_ert"
#define SHUTTLE_DISTRESS_UFO "distress_ufo"
#define SHUTTLE_DISTRESS_UPP "distress_upp"
#define SHUTTLE_DISTRESS_PMC "distress_pmc"
#define SHUTTLE_DISTRESS "distress"
#define SHUTTLE_ESCAPE_POD "escape_pod"
#define SHUTTLE_SUPPLY "supply"
#define SHUTTLE_SHIPELEVATOR "shipelevator"
#define SHUTTLE_ELEVATOR "elevator"
#define SHUTTLE_VEHICLE_SUPPLY "vehicle_supply"
#define SHUTTLE_SOM_VEHICLE_SUPPLY "som_vehicle_supply"
#define SHUTTLE_CAS_SOM "casplane_som"
#define SHUTTLE_CAS_DOCK_SOM "som_cas_dock"
