FROM mcr.microsoft.com/dotnet/aspnet:8.0.2-alpine3.18-amd64 AS base
WORKDIR /app
EXPOSE 5000

ENV ASPNETCORE_URLS=http://+:5000

FROM mcr.microsoft.com/dotnet/sdk:8.0.201-alpine3.18-amd64 AS build
ARG configuration=Release
WORKDIR /src
COPY ["MovieMVC.csproj", "./"]
RUN dotnet restore "MovieMVC.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "MovieMVC.csproj" -c $configuration -o /app/build

FROM build AS publish
ARG configuration=Release
RUN dotnet publish "MovieMVC.csproj" -c $configuration -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "MovieMVC.dll"]
