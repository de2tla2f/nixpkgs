{ lib
, buildGoModule
, fetchFromGitHub
, testers
, typioca
}:

buildGoModule rec {
  pname = "typioca";
  version = "2.7.0";

  src = fetchFromGitHub {
    owner = "bloznelis";
    repo = "typioca";
    rev = version;
    hash = "sha256-PVyEvPktb2ortmPf1afk6vXmcp91Zei8BLwGkRazFGA=";
  };

  vendorHash = "sha256-XiKn18WCbhVvsrIvTN/Yquj4mhq4n1X1jqdGUaMacV4=";

  ldflags = [
    "-s"
    "-w"
    "-X=github.com/bloznelis/typioca/cmd.Version=${version}"
  ];

  passthru.tests = {
    version = testers.testVersion {
      package = typioca;
    };
  };

  meta = with lib; {
    description = "Cozy typing speed tester in terminal";
    homepage = "https://github.com/bloznelis/typioca";
    changelog = "https://github.com/bloznelis/typioca/releases/tag/${src.rev}";
    license = licenses.mit;
    maintainers = with maintainers; [ figsoda ];
  };
}
