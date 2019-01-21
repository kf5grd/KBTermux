# KBTermux

KBTermux is a set of bash scripts and a Tasker profile for running Keybase in Termux.  

## Features
- Start Keybase and KBFS when your phone starts
- Keep Keybase logged in
- Keep KBFS running and available at all times

## Requirements
- A Keybase account and paper key
  - [keybase.io](https://keybase.io)
- [Tasker](https://tasker.joaoapps.com)
  - [[Play Store](https://play.google.com/store/apps/details?id=net.dinglisch.android.taskerm)]
- [Termux](https://termux.com)
  - [[Play Store](https://play.google.com/store/apps/details?id=com.termux)]
  - [[F-Droid](https://f-droid.org/repository/browse/?fdid=com.termux)]
- Termux:Task plugin
  - [[Play Store](https://play.google.com/store/apps/details?id=com.termux.tasker)]
  - [[F-Droid](https://f-droid.org/packages/com.termux.tasker/)]
- Termux:API plugin
  - [[Play Store](https://play.google.com/store/apps/details?id=com.termux.api)]
  - [[F-Droid](https://f-droid.org/packages/com.termux.api/)]

## Setup
Before you continue with the setup, make sure you have all of the [required apps](#requirements) installed.

### Termux Setup
In Termux, navigate to the folder where you downloaded the scripts and run the install script:
```
$ ./kbt-install.sh
```

This script will install the necessary Termux packages required by the scripts, and will symlink the scripts to `~/.termux/tasker`, which is required in order to run the scripts from Tasker.

### Tasker Setup
First you will need to import the KBTermux project into Tasker. This is the file called `KBTermux.prj.xml`. If you have this file in your Termux environment and need help copying to a folder on your phone where Tasker can access it, see [this article](https://wiki.termux.com/wiki/Internal_and_external_storage) on the Termux Wiki.

To import the project file, open Tasker and long press on the house icon on the bottom left corner of the screen, and choose `Import` from the menu. From there, navigate to where you saved the project file and select it to import it. Once you've imported the project you should have a new section next to the house icon called `KBTasker`, tap that section to switch over to it.

#### Keybase User Setup
Next we'll need to set up our Keybase login information. To do this, tap on the `Tasks` tab toward the top of Tasker, then long press on the task called `kbt_user_setup`, then tap the play icon toward the top right. This will run the user setup task. You'll only ever need to repeat this setup if you revoke your paper key, or if you want to run Keybase with a different user.

During this setup you will be asked for a few things:

- Keybase Username
  - This is the username you want to be loggd in as within Termux. This can be a different username than the one you use in the Android app.
- Encryption Password
  - Default: KBTermux
  - This is the password we'll use to encrypt the paper key while it's stored in Tasker. You should probably change this.
- Keybase Paperkey
  - This must be a valid paper key for the Keybase user you selected. You might want to generate a new paper key for this in case you need or want to revoke it in the future

Now that your login information is set up, you can long press the `kbt_oneshot_login` task and tap the play button at the top to run Keybase and KBFS in Termux. At this point you will want to [enable the profiles](#enabling-the-profiles) to make sure Keybase and KBFS don't get logged out.

Note: When the setup is done, your paper key will be encrypted with the password you chose, and stored in a Tasker variable. It's important to understand that while this is probably better than storing the key in plain text, it should **not** be considered secure, because the password for the encryption is also stored in a Tasker variable.

#### Enabling the Profiles
Now we need to tap on the `Profiles` tab at the top of Tasker. You will see 3 Profiles in here. 2 of them will be disabled, and you can enable them by tapping the switch to the right of each profile.

The `Login at Boot` profile will log you into keybase when your phone boots up. There will be a bit of delay between the time when your phone starts, and when Tasker starts. I've added an extra 10 second delay after Tasker starts because there is usually a lot happening when your phone first boots up.

The `Periodic Login` profile will check if Keybase is running and logged in as the current user, and if not it will run Keybase again and log in the user. It also checks to make sure KBFS is running and if not, it will start it. It runs these checks every 10 minutes, and you can tap on the profile if you'd like to adjust the interval.
