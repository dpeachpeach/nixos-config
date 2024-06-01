{
	programs.git = {
		enable = true;
		userName = "David Petre";
		userEmail = "davidpetre@uchicago.edu";
		extraConfig = {
			user.signingKey =  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEf9vNJ+4BAtlKhRPZL7myDhiew3NydQn4jkLXNTQpYV david@david-nuc";
			gpg.format = "ssh";
			commit.gpgsign = true;
			tag.gpgsign = true;
		};

	};
}
