/*
    MultiSTOP - Give the F-STOP camera to the player who touches a trigger_once.

    Attach this script to a logic_script entity.
    The Hammer output from trigger_once should call the GiveCamera function.

    Required game_player_equip entity:
      Name:       multistop_camera_equip
      Add keyvalue: weapon_camera = 1
      Spawnflag:  Use Only (enabled)
*/

function GiveCamera()
{
    // The trigger's OnStartTouch output passes the touching entity as activator.
    if (activator == null)
    {
        printl("[MultiSTOP] GiveCamera: No activator was passed.");
        return;
    }

    // Ignore anything that is not a player.
    if (activator.GetClassname() != "player")
    {
        return;
    }

    // Find the equipment entity configured to give weapon_camera.
    local cameraEquip = Entities.FindByName(null, "multistop_camera_equip");

    if (cameraEquip == null)
    {
        printl("[MultiSTOP] GiveCamera: Could not find game_player_equip named multistop_camera_equip.");
        return;
    }

    // Fire Use with the touching player as the activator, so only that player
    // receives the camera in multiplayer.
    EntFireByHandle(cameraEquip, "Use", "", 0.0, activator, self);

    printl("[MultiSTOP] Camera equipment triggered for player " + activator.entindex());
}
