# FROM --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# ARG TARGETARCH

# COPY . /source

# WORKDIR /source/AntonOvesen.Services.Utilities/AntonOvesen.Services.Utilities

# RUN --mount=type=cache,id=nuget,target=/root/.nuget/packages \
#     dotnet publish -a amd64 --use-current-runtime --self-contained false -o /app

# FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
# WORKDIR /app
# EXPOSE 8080
# EXPOSE 8443

# COPY --from=build /app .

# ARG UID=10001
# RUN adduser \
#     --disabled-password \
#     --gecos "" \
#     --home "/nonexistent" \
#     --shell "/sbin/nologin" \
#     --no-create-home \
#     --uid "${UID}" \
#     appuser
# USER appuser

# ENTRYPOINT ["dotnet", "AntonOvesen.Services.Utilities.dll"]

# FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
# WORKDIR /src
# COPY . .

# RUN dotnet publish "AntonOvesen.Services.Utilities.csproj" -c Release -o /app/publish

# FROM mcr.microsoft.com/dotnet/aspnet:8.0
# WORKDIR /app

# EXPOSE 80
# EXPOSE 443

# COPY --from=publish /app/publish .
# ENTRYPOINT ["dotnet", "AntonOvesen.Services.Utilities.dll"]

# FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
# WORKDIR /app
# EXPOSE 80
# EXPOSE 443

# FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
# WORKDIR /src
# COPY ["./AntonOvesen.Services.Utilities.csproj", "."]
# RUN dotnet restore "AntonOvesen.Services.Utilities.csproj"
# COPY . .
# RUN dotnet build "AntonOvesen.Services.Utilities.csproj" -c Release -o /app/build

# FROM build AS publish
# RUN dotnet publish "AntonOvesen.Services.Utilities.csproj" -c Release -o /app/publish

# FROM base AS final
# WORKDIR /app
# COPY --from=publish /app/publish .
# ENTRYPOINT ["dotnet", "AntonOvesen.Services.Utilities.dll"]

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