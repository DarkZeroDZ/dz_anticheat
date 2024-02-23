#define FILTERSCRIPT
#include <a_samp>

//Defines:
#undef MAX_PLAYERS
#define MAX_PLAYERS 50
//-------------------
#define Rot 0xFF000000
#define Weiss 0xFFFFFFFF
//-------------------
#define HOMEPAGE "www.Your-Homepage.com" 
#define ADMINNAME "The Server"
//-------------------
#define Kickplayer // Comment this out if a player should get banned instead

//Variables:
new Antifastkill[MAX_PLAYERS];
new stringtu[128];

//Forwards:
forward AntifastkillTimer(playerid);

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("Anti Fastkill by DarkZero successfully started.");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	print("\n--------------------------------------");
	print("Anti Fastkill by DarkZero successfully unloaded.");
	print("--------------------------------------\n");
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    Antifastkill[playerid]++;
    SetTimerEx("AntifastkillTimer", 1000,false,"i",playerid);
    SendDeathMessage(killerid,playerid,reason);
	return 1;
}

public AntifastkillTimer(playerid)
{
    Antifastkill[playerid]--;
    if(Antifastkill[playerid] > 2)
    {
        #if defined Kickplayer
        SendClientMessage(playerid, Rot, "YOU HAVE BEEN KICKED!");
		format(stringtu, sizeof(stringtu), "Name: %s", GetName(playerid));
		SendClientMessage(playerid, Weiss, stringtu);
		SendClientMessage(playerid, Weiss, "Reason: Fastkill Cheat");
		SendClientMessage(playerid, Weiss, "Admin: "#ADMINNAME"");
		format(stringtu, sizeof(stringtu), "Date: %s", GetDate());
		SendClientMessage(playerid, Weiss, stringtu);
		format(stringtu, sizeof(stringtu), "Time: %s", GetTime());
		SendClientMessage(playerid, Weiss, stringtu);
		format(stringtu, sizeof(stringtu), "IP: %s", GetIP(playerid));
		SendClientMessage(playerid, Weiss, stringtu);
		SendClientMessage(playerid, Weiss, "If you want to complain about this kick, post a complain");
		SendClientMessage(playerid, Weiss, "on our forums at "#HOMEPAGE"! Press F8 to take a screenshot!");
  		TogglePlayerControllable(playerid, false);
        Kick(playerid);
        #else
        SendClientMessage(playerid, Rot, "YOU HAVE BEEN BANNED!");
		format(stringtu, sizeof(stringtu), "Name: %s", GetName(playerid));
		SendClientMessage(playerid, Weiss, stringtu);
		SendClientMessage(playerid, Weiss, "Reason: Fastkill Cheat");
		SendClientMessage(playerid, Weiss, "Admin: "#ADMINNAME"");
		format(stringtu, sizeof(stringtu), "Date: %s", GetDate());
		SendClientMessage(playerid, Weiss, stringtu);
		format(stringtu, sizeof(stringtu), "Time: %s", GetTime());
		SendClientMessage(playerid, Weiss, stringtu);
		format(stringtu, sizeof(stringtu), "IP: %s", GetIP(playerid));
		SendClientMessage(playerid, Weiss, stringtu);
		SendClientMessage(playerid, Weiss, "If you want to complain about this ban, post a complain");
		SendClientMessage(playerid, Weiss, "on our forums at "#HOMEPAGE"! Press F8 to take a screenshot!");
  		TogglePlayerControllable(playerid, false);
        Ban(playerid);
        #endif
    }
    return 1;
}

stock GetName(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid,name,sizeof(name));
	return name;
}

stock GetTime()
{
	new Time[20],Hour,Minute,Second;
	gettime(Hour,Minute,Second);
	format(Time,sizeof(Time),"%02d:%02d:%02d",Hour,Minute,Second);
	return Time;
}

stock GetDate()
{
	new Date[40],Day,Month,Year;
	getdate(Year,Month,Day);
	format(Date,sizeof(Date),"%d. %s %d",Day,GetMonth(Month),Year);
	return Date;
}

stock GetMonth(month)
{
	new string[40];
	string="Unknown month";
	switch(month)
	{
	    case 1:
	        string="January";
		case 2:
		    string="February";
        case 3:
		    string="March";
        case 4:
		    string="April";
        case 5:
		    string="May";
		case 6:
		    string="June";
		case 7:
		    string="July";
		case 8:
		    string="August";
		case 9:
		    string="September";
		case 10:
		    string="October";
		case 11:
		    string="November";
		case 12:
		    string="December";
	}
	return string;
}

stock GetIP(playerid)
{
	new ip[24];
	GetPlayerIp(playerid, ip,sizeof(ip));
	return ip;
}
