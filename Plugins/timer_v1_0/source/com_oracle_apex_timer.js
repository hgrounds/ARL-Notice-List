/*
 * Timer Plug-in v1.0 - http://www.oracleapex.info/
 * 
 * Dual licensed under the MIT and GPL licenses:
 *   http://www.opensource.org/licenses/mit-license.php
 *   http://www.gnu.org/licenses/gpl.html
*/
com_oracle_apex_timer = {

  // Contains pointers to the created timers so that we are able to clear them by name
  // The object is "indexed" by the timer name
  createdTimers:{},
  
  // Function to initialize the timer plug-in. This function is called
  // by the dynamic action.
  init: function(){
    // It's better to have named variables instead of using
    // the generic ones, makes the code more readable
    var lAction            = this.action.attribute01,
        lTimerName         = this.action.attribute02,
        lExpireIn          = parseInt(this.action.attribute03, 10),
        lOccurrence        = this.action.attribute04,
        lAffectedElements$ = this.affectedElements;

    // Function which is called when the timer expires.
    // It's responsible to call our "timer_expired" event so that
    // dynamic actions can react on the timer expiry.
    // We use a local function, so that we have closure access
    // to the parameters used to initialize the timer
    function timerExpired(){
      // Reinitialize the timer if we have infinite occurrence,
      // otherwise delete our pointer to our fired timer
      if (lOccurrence==="infinite") {
        com_oracle_apex_timer.createdTimers[lTimerName] = setTimeout(timerExpired, lExpireIn);
      } else {
        delete com_oracle_apex_timer.createdTimers[lTimerName];
      }
      // Fire our "expire_timer" event so that a dynamic action can react onto it
      lAffectedElements$.trigger("timer_expired.COM_ORACLE_APEX_TIMER", lTimerName);
    };

    // Do we have to create a new timer?
    if (lAction === "add") {
      // Does the timer exist? Clear it first.
      if (com_oracle_apex_timer.createdTimers[lTimerName]) {
        clearTimeout(com_oracle_apex_timer.createdTimers[lTimerName]);
      }
      // Add new timer. Note: we don't use setInterval, so that we
      // don't have to distinguish in our remove action if we have to
      // use clearTimeout or clearInterval 
      com_oracle_apex_timer.createdTimers[lTimerName] = setTimeout(timerExpired, lExpireIn);

    // Or do we have to remove an existing one?
    } else if (lAction === "remove") {
      // Does the timer exist?
      if (com_oracle_apex_timer.createdTimers[lTimerName]) {
        clearTimeout(com_oracle_apex_timer.createdTimers[lTimerName]);
        delete com_oracle_apex_timer.createdTimers[lTimerName];
      }
    }
  }
};