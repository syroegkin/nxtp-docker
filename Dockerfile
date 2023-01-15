FROM mcr.microsoft.com/dotnet/core/aspnet:3.0 AS base
WORKDIR /app
EXPOSE 12300

FROM mcr.microsoft.com/dotnet/core/sdk:3.0 AS build
WORKDIR /src
RUN apt-get update && apt-get install git -y
RUN git clone --depth 1 --branch v1.65 https://github.com/Threetwosevensixseven/nxtp.git
RUN dotnet restore "nxtp/src/core/NxtpServer/NxtpServer.csproj"

WORKDIR "/src/nxtp/src/core/NxtpServer"
RUN dotnet build "NxtpServer.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "NxtpServer.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "NxtpServer.dll"]
