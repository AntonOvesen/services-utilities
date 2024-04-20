FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG version
WORKDIR /src

COPY ["AntonOvesen.Services.Utilities/AntonOvesen.Services.Utilities.csproj", "AntonOvesen.Services.Utilities/"]

RUN dotnet restore "AntonOvesen.Services.Utilities/AntonOvesen.Services.Utilities.csproj" 

COPY . .

Run echo ${version}

RUN dotnet publish "AntonOvesen.Services.Utilities/AntonOvesen.Services.Utilities.csproj" -c Release -o out /p:NuGetVersion=${version}

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

EXPOSE 8080
EXPOSE 8443

COPY --from=build /src/out .    
ENTRYPOINT ["dotnet", "AntonOvesen.Services.Utilities.dll"]