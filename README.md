docker-lemp-dev
===============

**Do not use in production**.

I don't work with PHP anymore. Well, not if I can avoid it. But sometimes there is no choice, as Wordpress is a de facto reference. 
Since I don't want to pollute my machine with useless dependencies, I sandboxed them in a Docker.

`docker run -p 80:80 -v <path_to_your_project>:/var/www -d augnustin/lemp-dev`

This will allow you to :
- serve your PHP project on port 80
- load your `backup.sql` in your DB
- navigate through it with Phpmyadmin 