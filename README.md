# malfurious/docker-mangosweb

<p align="center">
  <img src="https://github.com/Malfurious/docker-examples/raw/master/docker-mangosweb/MangosWeb-Icon.PNG">
</p>

### What is this?

MaNGOSWeb is a graphical web front-end for managing a mangos based World Of Warcraft Private Server.
For in depth information, visit https://github.com/paintballrefjosh/MaNGOSWebV4.

#### Important Note

This Docker requires an external MySql or MariaDB database.

### MaNGOSWeb Features

 - Support for Mangos Based Cores (Trinity, Darkice)
 - Full template system allowing any layout, including non-blizzlike templates
 - New SDL idea makes any emulator / patch combo possible with even the newest updates of v3
 - SDL backend allows most task to be done without direct database access. Allows modules that you make to be cross-emu support, without coding for it.
 - Easily manage user accounts
 - Edit site configuration settings right in the Admin Control Panel (ACP)
 - Frontpage links, vote sites, shop items, and languages are all managed in the ACP
 - Tons of character tools including name change, re-customization, level adjuster and more
 - New updates? No Problem! Update the CMS right from the ACP with the new Remote Updater
 - Module system
 - Unlimited amount of realms supported
 - Users can manage there accounts with ease
 - Password recovery system using the secret question system
 - Account registration features such as "Invite Only", and "Account Activation"
 - fully Re-written and tested donation system
 - Web point system - Earn points for donating and voting
 - Shop system for users to spend their Web Points
 - Much Much More!

### Ports (Configurable)

MaNGOSWeb:
- **7788**

### Environment variables

| Variable | Description | Type | Default value |
| -------- | ----------- | ---- | ------------- |
| **MYSQL_HOST** |MariaDB instance ip/hostname | **required** | null
| **MYSQL_PORT** | MariaDB instance port | **required** | 3306
| **MYSQL_USER** | MariaDB MaNGOSWeb Username | **required** | null
| **MYSQL_PASS** | MariaDB MaNGOSWeb Password | **required** | mangos
| **MYSQL_DB** | MariaDB MaNGOSWeb Database Name | **required** | mangosweb
| **NGINX_PORT** | NGINX Listening Port | **required** | 7788
| **DISABLE_INSTALL** | Enable/Disable MaNGOSWeb Installer | *optional* | false

### Installation

#### 1. Set required Environment Variables.
Create a New Database on your SQL server named "mangosweb", or whatever you prefer. Then create a new user, and grant them all privileges for the new database.
After looking at the above tabe, set variables as required. Making sure to keep DISABLE_INSTALL=false for now.
Then start the docker.

#### 2. MaNGOSWeb Setup: Goto http://[YOUR IP]:[NGINX PORT]
Follow the installation instructions, steps 1 & 2 are self explanatory.

<p align="center">
  <img src="https://github.com/Malfurious/docker-examples/raw/master/docker-mangosweb/mangosweb-install-step1.PNG">
</p>

At Step 3, enter the required information as described in the above image. For <MySql realmd Username>, enter the username for an account on your SQL server with permissions for the realm database.(Usually the database is called "realmd") Then enter the applicable password for that account on the next line. Finally, for <MySql realm DB Name>, enter the name of your realm database. Then click "Install Database".
  
<p align="center">
  <img src="https://github.com/Malfurious/docker-examples/raw/master/docker-mangosweb/mangosweb-install-step2.PNG">
</p>
  
At Step 4, enter the required information as described in the above image. There are 2 sections, 1 for the characters database information, and 1 for the world database. Follow the same steps used for the previous section, using account names and passwords that have appropriate permissions for their given databases. (The characters database is usually named "characters", and the world database is usually named "mangos" or "world" depending on the server software.)
When complete, click the Submit button. The last step asks for you to create an Admin account for managing the site. It is highly recommended you use an existing account you already created on your server.
If all goes without error, you are finished with the Installation!
Shutdown the docker and remove the container. Then restart the docker with the same settings as before, except for setting DISABLE_INSTALL=true. Once the docker starts, going to http://[YOUR IP]:[NGINX PORT] should bring you to the homepage, where you can login near the top right with your previously provided account information. Once logged in, you can click "Admin Panel" on the left navigation bar, taking you to the pages allowing you to further configure your installation.


#### Setup Complete!
