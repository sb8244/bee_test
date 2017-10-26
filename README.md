# For Reddit

Requirements:
- [ ] Django or Node.js Framework
- [x] Photo upload endpoint
- [x] View photo endpoint
- [x] View photo feed endpoint
- [x] Authentication system that only allows authenticated users to upload photos but all users to view photos
- [x] Automated testing
- [x] Code coverage does not need to be complete, just generate that some critical functions of the system have tests attached to them.
- [x] Write-up on the systems design pattern choices This should explain framework decisions, where the system works scales well, and where the system could improve. This should be a quick project, so it is expected to be functional but not flawless.

Going to use Rails because I don't know Django and "meh Node".

## Time

Start: 18:28
Dinner break start: 18:43
Dinner break end: 19:09
Writeup: 19:56

## Write up

Rails was chosen as it makes RESTful endpoint creation very simple. I also have experience in it. Devise was chosen
as the de-facto user auth implementation for Rails, but a JWT auth token is chosen to allow bearer token authorization
to the authenticated endpoints.

The system uses file upload for ease of use, but S3 or equivalent uploading is ideal in production loads. This is because
the file system could become saturated with writes under high load, and distributing this to multiple servers means that
the content has to be distributed. All of that is not difficult to add, but the setup is worth more than this simple project.
