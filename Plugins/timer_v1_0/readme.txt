TIMER, 1.0
==========
This plug-in is a dynamic action which allows to periodically fire other dynamic actions in the browser.
For example to refresh a region. But you can perform any action you want, because the plug-in just provides
the infrastructure so that you can hook up your own actions which you want to execute periodically.


TABLE OF CONTENTS
=================

* Installation
* Advanced Installation
* How to use
* Deinstallation
* License and Terms of Use
* Support


INSTALLATION
============
1. Ensure you are running Oracle APEX version 4.0 or higher
2. Unzip and extract all files
2. Access your target Workspace
3. Select the Application Builder
4. Select the Application where you wish to import the plug-in 
   (plug-ins belong to an application, not a workspace)
5. Access Shared Components > Plug-Ins
6. Click [Import >]
7. Browse and locate the installer file, dynamic_action_plugin_com_oracle_apex_timer.sql
8. Complete the wizard

If the plug-in already exists in that application, you will need to confirm that you 
want to replace it.  Also, once imported, this plug-in can be installed into additional
applications within the same workspace.  Simply navigate to the Export Repository 
(Export > Export Repository), click Install, and then select the target application.
Once the install file is no longer needed, it can be removed from the Export Repository.


ADVANCED INSTALLATION
=====================
1. Follow the steps in INSTALLATION
2. Copy the files of the directory "server" to the /images/plugins/timer_v1_0
   or any other directory on the web server
3. Set the "File Prefix" attribute of the plug-in to #IMAGE_PREFIX#plugins/timer_v1_0/

This will provide better performance, because the static files will be served by the web server
instead of reading them each time from the database.


HOW TO USE
==========
1. Install the plug-in (see INSTALLATION)
2a. Create a new dynamic action
 b. Use the "Advanced Wizard"
 c. Pick "Page Load" as event (you can use other events as well to create the timer)
 d. Select the plug-in "Timer" as action
 e. Follow the wizard and use Item Level Help to get more information about the
    purpose and usage of the different settings
 f. Set the "Affected Elements" to the component you want to act on, like a region
3a. Create a new dynamic action to react on the expiry of the timer
 b. Use the "Advanced Wizard"
 c. Set the event to "Timer Expired [Plug-in]" and
 d. "Selection Type" to the same value as you have used for "Affected Elements"
    when you created the timer
 e. Pick the action which you want to perform (for example Refresh)

Note that you can also update existing dynamic actions to use this new plug-in, 
once installed.


DEINSTALLATION
==============
To completely remove the plug-in:

1. Access the plug-in under Shared Components > Plug-Ins
2. Click [Delete]
   Note: If the [Delete] button doesn't show that indicates the plug-in is in use within the
         application.  Click on 'Utilization' under 'Tasks' to see where it is used.


LICENSE AND TERMS OF USE
========================
Copyright 2010, Oracle. All rights reserved.

This dynamic action plug-in is dual licensed under the MIT and GPL licenses:

  * http://www.opensource.org/licenses/mit-license.php
  * http://www.gnu.org/licenses/gpl.html

Terms of use: http://www.oracle.com/technetwork/developer-tools/apex/plugins-155231.html#TERMS


SUPPORT
=======
These plug-in is not part of Oracle Application Express software and is therefore not supported by Oracle Support.
Any issues with it can be discussed on the Application Express Forum at http://forums.oracle.com/forums/forum.jspa?forumID=137
