#first stage base image1
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /source

#copy csproj and restore dependancies
COPY *.csproj  .
RUN dotnet restore

# Copy and publish application file
COPY . .
RUN dotnet publish -c release -o /app


# final stage image
FROM  mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app .

ENTRYPOINT [ "dotnet", "hrapp.dll" ]