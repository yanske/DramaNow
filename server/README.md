# Rails Server

### Database 

* User: id, unique key
* Drama: id, title, site, latest episode, link_template, require_fetch, last_new_episode, imglink
* UserDramas (Connects user with dramas): id, userid, dramaid, episode number, episode length
* Watching (User polling events): id, userdramaid, timestamp in show

### Key Functions

* Creating an user / signing in: pass random, unique token around
* Updating drama: create new watching event
* Returning watch list (GraphQL): get user's userdramas, and their latest watching: -> check if done, if done, check for next episode exists
* Checking for new episode(< daily job): bg job that checks for dramas w/o a last_new_episode or a valid last_new_episode (ie within a few months)
