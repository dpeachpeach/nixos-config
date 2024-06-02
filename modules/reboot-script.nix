{ pkgs, inputs, config, ... }:

{
	# This is because I forgot to remove sleep from 
	# the BIOS and I'm hacking together a solution while I'm in
        # Boston for my internship. This reboots the NUC every 2 hours.

	systemd.timers."reboot-script" = {
	  wantedBy = [ "timers.target" ];
	    timerConfig = {
		OnCalendar = "*-*-* 00/2:00:00"
	    };
	};

	systemd.services."reboot-script" = {
	  script = ''
		reboot
	  '';
	  serviceConfig = {
	    Type = "oneshot";
	    User = "root";
	  };
	};

}
