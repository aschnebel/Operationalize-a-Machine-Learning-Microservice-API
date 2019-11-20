FROM python:3.7.3-stretch

## Step 1:
# Create a working directory
WORKDIR /app

## Step 2:
# Copy requirements txt to working directory
# Since requirements txt will less likely to change, we will gain a boost in
# the overall build time
COPY requirements.txt /app

## Step 3:
# Install packages from requirements.txt
# hadolint ignore=DL3013
RUN pip install --upgrade pip && \
    pip install --trusted-host pypi.python.org -r requirements.txt

## Step 4:
# Copy other source code which happen to change more frequently
COPY . model_data /app/
COPY . app.py /app/ 

## Step 5:
# Expose port 80
EXPOSE 80

## Step 5:
# Run app.py at container launch
CMD ["python", "app.py"]
