# Use Ubuntu as the base image
FROM ubuntu:latest

# Set working directory
WORKDIR /app

# Install necessary packages in a single step and clean up
RUN apt-get update && apt-get install -y fortune-mod cowsay netcat-openbsd && rm -rf /var/lib/apt/lists/*

# Check if packages are installed (for debugging)
RUN ls -l /usr/games/fortune && ls -l /usr/games/cowsay

# Copy the script into the container
COPY wisecow.sh .

# Make script executable
RUN chmod +x ./wisecow.sh

# Ensure script runs with bash and correct paths
RUN sed -i 's/cowsay/\/usr\/games\/cowsay/g' wisecow.sh
RUN sed -i 's/fortune/\/usr\/games\/fortune/g' wisecow.sh

# Expose port
EXPOSE 4499

# Run the script using bash
CMD ["/bin/bash", "./wisecow.sh"]
