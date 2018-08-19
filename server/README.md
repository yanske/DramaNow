# Rails Server

### Database 

* User: id, unique key
* Drama: id, title, site, latest episode, link_template, last_new_episode, imglink
* UserDramas (Connects user with dramas): id, userid, dramaid, episode number, episode length
* Watching (User polling events): id, userdramaid, timestamp in show

### Key Functions

* Creating an user / signing in: pass random, unique token around
* Updating drama: create new watching event
* Returning watch list: get user's userdramas, and their latest watching: -> check if done, if done, check for next episode exists
* Checking for new episode(< daily job): bg job that checks for dramas w/o a last_new_episode or a valid last_new_episode (ie within a few months)

### Controllers / Services

* UserController
* WatchingController

* Service to process watching request
* Service to process update request

### Loading list

* get all user dramas, and associated drama
* get latest watchings of user dramas
* depending on time, return current episode, or next if exist, else none
* cache results and return

### Job

* get dramas last updated within a month (make sure drama's last updated is not nil)

* parse
