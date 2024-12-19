 🐳 Part 1: Docker Compose Setup for App Service					 
											 
	- Set up a service called app using the Docker image from			 
   > [Homework_1](https://github.com/sashaloven/dan_it_homework/tree/main/Homework/Docker/Homework_1) <
	- The Docker image for app should be built dynamically using docker-compose.     
											 
 🐳 Part 2: Nginx Reverse Proxy Setup							 
											 
	- Set up an nginx service to act as a reverse proxy for the app service.	 
	- The nginx service should handle requests on HTTP port 8080.			 
	- Configure the nginx server to forward traffic to the app service.		 
											 
 3. The nginx configuration should be located at:					 
											 
	- /etc/nginx/conf.d/default.conf inside the container.				 
