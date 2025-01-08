FROM python:3.9-slim

# Create a workdir in container
WORKDIR /app

# Copy script in container
COPY . .

# Expose port 8082
EXPOSE 8082

# Run the script
CMD ["python", "python-random.py"]

