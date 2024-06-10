{ pkgs, inputs, config, ... }:

# This script is currently defunct, as I figured out the issue that required its usage
# I'm keeping it here because I would like to set up a policy that reboots every few days or so.

{

	systemd.timers."reboot-script" = {
	  wantedBy = [ "timers.target" ];
	    timerConfig = {
		OnCalendar = "Mon *-*-* 00:00:00";
	    };
	};

	systemd.services."reboot-script" = {
	  serviceConfig = {
	    Type = "oneshot";
	    ExecStart = "${pkgs.systemd}/bin/systemctl reboot";
	  };
	};

}
