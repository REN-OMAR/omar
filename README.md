[PipelineStatusBadge]: https://gitlab.com/firstTerraner/proclubs-api/badges/main/pipeline.svg
[CoverageBadge]: https://gitlab.com/firstTerraner/proclubs-api/badges/main/coverage.svg
[ProjectUrl]: https://gitlab.com/firstTerraner/proclubs-api/commits/main
[ProjectPage]: https://firstTerraner.gitlab.io/proclubs-api


[![pipeline status][PipelineStatusBadge]][ProjectUrl]
[![coverage report][CoverageBadge]][ProjectUrl]
## Fifa Pro Clubs API built on NodeJS/ES6 ##

Wrapper to get stats for **FIFA Pro Clubs teams, players and matches**.

Visit an open source pro clubs [web-app](https://virtualpro.space) that uses this repo and is based on React, NextJS, Material-UI and Redis.

[Web-app source code](https://firstTerraner.gitlab.io/proclubs-api)

[Proclubs-api Docs](https://firstTerraner.gitlab.io/proclubs-api)

## Targeting **ESnext** - Tested with node **>=** v**15.3.0**
because i ❤ [Optional chaining](https://2ality.com/2019/07/optional-chaining.html)

## Installing from source

### Linux, MacOS, Windows, *BSD, Solaris, WSL, Android, Raspbian

```bash
git clone https://gitlab.com/firstTerraner/proclubs-api.git
cd proclubs-api
npm i
npm start

# run tests
npm test

# build docs
npx typedoc $(find 'src' -type f -name '*.ts' -not -name '*.test.ts' -printf "%p ") --out docs


```


That's it!



## How to use

After you install the package, you can include **proclubs-api** within your code such this:

```typescript
const proClubsApi = require('proclubs-api`);
```

You can also import the functions like this (ES6):

```typescript
import { getClubSearch } from 'proclubs-api/dist/core/club'
```

### Clubs

Note: All endpoints need a platform parameter.

Supported platforms written as follow: ps4, ps5, xboxone, xbox-series-xs, pc

platform: TPlatformType
name: string
clubId: number

We can perform different operations according clubs:

| Function  | Params |
| ------------- | ------------- |
| `getClubSearch` | (platform: TPlatformType, name: string) |
| `getClubIdByName` | (platform: TPlatformType, name: string) |
| `getClubMembers` | (platform: TPlatformType, clubId: number) |
| `getClubMemberStats` | (platform: TPlatformType, clubId: number) |
| `getClubStats` | (platform: TPlatformType, clubId: number) |
| `getClubMatchHistory` | (platform: TPlatformType, clubId: number, gameType: TGametype) |
| `getClubInfo` | (platform: TPlatformType, clubId: number) |


Example:

```typescript
const resp = await getClubInfo('ps4', 13607);
```

The parameter gameType accepts 2 types:
'matchType9' & 'matchType13' (9 for division & 13 for cup)

### Leaderboard

We can perform different operations according leaderboard:

| Function  | Params |
| ------------- | ------------- |
| `getOverallLeaderboard` | (platform: TPlatformType) |
| `getSeasonLeaderboard` | (platform: TPlatformType) |


Example:

```typescript
const resp = await getOverallLeaderboard('ps4');
```

<!-- ### Members -->

<!-- We can perform different operations according players/members:

-  getMembersClubStats(clubId, blazeId)
-  getMembersStats(blazeId) -->


<!-- _getMembersClubStats_  retrieves actual data of a player inside a club. This operation require a **_clubId_** and **_blazeId_** (playerId) as parameters.

_getMembersStats_ retrieves individual data of a player. This operation require a **_blazeId_** (playerId) as parameter.


Example:

```
const resp = await member.getMembersClubStats('13607', 'rE4p14Gj8KOtkGq63eL8mA!!:BrUy43tm4sv8Qz5jmZvGkg!!');
``` -->

<!-- ### Settings

- getSettings()


Example:

```
const resp = await settings.getSettings();
``` -->


## Contributing

Contributors and committers are welcome.


## Made with ❤ by

- Nicolas Taboada (Javascript developer)
- E-mail: ntaboada93@gmail.com
- StackOverflow: nicolas-taboada


## License

MIT license. Copyright © 2018.
