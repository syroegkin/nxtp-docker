FROM mcr.microsoft.com/dotnet/core/aspnet:3.0 AS base
WORKDIR /app
EXPOSE 12300

FROM mcr.microsoft.com/dotnet/core/sdk:3.0 AS build
WORKDIR /src
COPY ["nxtp/src/core/NxtpServer/NxtpServer.csproj", "NxtpServer/"]
COPY ["nxtp/src/core/NxtpData/NxtpData.csproj", "NxtpData/"]
RUN dotnet restore "NxtpServer/NxtpServer.csproj"
COPY nxtp/src/core/NxtpServer ./NxtpServer
COPY nxtp/src/core/NxtpData ./NxtpData

WORKDIR "/src/NxtpServer"
RUN dotnet build "NxtpServer.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "NxtpServer.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "NxtpServer.dll"]
