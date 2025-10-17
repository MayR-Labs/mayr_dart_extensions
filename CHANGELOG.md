# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-01-16

### Initial Release

This is the initial release of **mayr_dart_extensions** as a pure Dart package, migrated from the previous Flutter-based package.

#### Features

**Bool Extensions**
- `choose(trueValue, falseValue)` - Select value based on boolean
- `toInt()` - Convert to integer (1 for true, 0 for false)
- `toYesNo()` - Convert to string representation
- `not` - Returns negation of the boolean

**DateTime Extensions**
- **Checkers**: `isAfternoon`, `isMorning`, `isEvening`, `isNight`, `isToday`, `isTomorrow`, `isYesterday`, `isSameDay()`, `isInPast`, `isInFuture`
- **Utilities**: `startOfDay()`
- **Manipulators**: `addDays()`, `addMonths()`, `addYears()`, `addHours()`, `addMinutes()`, `addSeconds()`, `subDays()`, `subMonths()`, `subYears()`, `subHours()`, `subMinutes()`, `subSeconds()`
- **Age**: `toAge()`, `isAgeOlder()`, `isAgeYounger()`, `isAgeEqualTo()`, `isAgeBetween()`
- **Formatting**: `format()`, `toDayOrdinal()`, `toTimeAgoString()`, `toTimeString()`, `toShortDate()`

**Duration Extensions**
- `delay()` - Delays execution for the duration
- `toReadableString()` - Human-readable format (e.g., '2h 30m')
- `isLongerThan()` - Compare durations
- `isShorterThan()` - Compare durations

**Dynamic Extensions**
- `nullOnDebug<T>()` - Returns null in debug mode
- `onlyOnDebug<T>()` - Returns value only in debug mode
- `maybe<T>()` - Randomly returns null based on probability
- `orDefault()` - Returns fallback value if null

**Number Extensions**
- **Comparisons**: `isEqual()`, `isGreaterThan()`, `isLessThan()`, `isBetween()`, `isPositive`, `isNegativeNumber`, `isZero`
- **Clamping**: `clampMin()`, `clampMax()`
- **Integer**: `isEvenNumber`, `isOddNumber`, `times()`, `timesIndexed()`
- **Random**: `randomLess()`, `randomMore()`
- **Double**: `toDecimalPlaces()`
- **Formatting**: `formatAsCurrency()`, `formatAsDecimal()`, `formatAsNumber()`
- **Duration**: `days`, `hours`, `minutes`, `seconds`, `milliseconds`, `microseconds`

**String Extensions**
- **Utilities**: `matchesRegExp()`, `toBool`, `toDateTime()`, `toRegExp()`, `toUri()`, `limit()`, `mask()`, `reverse()`, `isBlank`, `isNotBlank`, `removeWhitespace()`, `countOccurrences()`, `truncate()`, `wrap()`, `removePrefix()`, `removeSuffix()`
- **Pretty Printing**: `prettyJson()`, `prettyXml()`, `prettyYaml()`
- **Casing**: `camelCase`, `capitalised`, `kebabCase`, `pascalCase`, `snakeCase`, `titleCase`
- **Case Checkers**: `isCamelCase`, `isPascalCase`, `isSnakeCase`, `isKebabCase`, `isTitleCase`, `isCapitalised`, `isUpperCase`, `isLowerCase`
- **Pattern Checkers**: `isEmail`, `isURL`, `isUlid`, `isUuid`, `isSlug`, `isHexColor`, `isIPAddress`, `isNum`, `isAlphabetOnly`, `isNumericOnly`

**List/Iterable Extensions**
- **Query**: `firstOrNull()`, `lastOrNull()`, `singleWhereOrNull()`, `containsWhere()`, `indexWhereOrNull()`
- **Safe Access**: `getOrNull()`, `getOrDefault()`
- **Transformations**: `chunked()`, `mapIndexed()`, `whereNotNull()`, `distinctBy()`, `flatten()`, `sortedBy()`, `sortedByDesc()`, `flip()`
- **Aggregations**: `sumBy()`, `averageBy()`, `min()`, `max()`, `countWhere()`
- **Mutations**: `insertIf()`, `replaceWhere()`, `removeWhereNot()`, `updateWhere()`, `addIf()`, `addAllIf()`, `append()`, `appendAll()`, `appendIf()`, `appendAllIf()`, `pop()`, `filter()`, `unique()`
- **Utility**: `isNullOrEmpty()`, `joinToString()`, `forEachIndexed()`

**Map Extensions**
- **Safe Access**: `getOrNull()`, `getOrDefault()`
- **Transformations**: `mapKeys()`, `mapValues()`, `filterKeys()`, `filterValues()`, `invert()`
- **Merge**: `merge()`, `mergeIfAbsent()`, `combine()`
- **Utility**: `keysWhere()`, `valuesWhere()`, `toQueryString()`

**Set Extensions**
- `toggle()` - Add if missing, remove if present
- `intersects()` - Check for intersection
- `isSubsetOf()` - Check if subset
- `isSupersetOf()` - Check if superset
- `unionAll()` - Union of multiple sets
- `without()` - Remove element

**Humanize Extensions**
- **Duration**: `humanize()` - Convert to "2 hours, 3 minutes"
- **DateTime**: `humanize()` - Relative time ("just now", "3 hours ago", etc.)
- **Numbers**: `humanizeNumber()`, `humanizeOrdinal()`, `humanizeCount()`, `humanizePercentage()`, `humanizeFileSize()`

**Object Extensions**
- `let()` - Transform object inline
- `also()` - Execute side effects while maintaining object for chaining

**Tools**
- `MayrDateTimeFormats` - Common date/time format patterns

### Changed
- Package renamed from `mayr_extensions` to `mayr_dart_extensions`
- Migrated to pure Dart (removed all Flutter dependencies)
- Updated ownership to MayR Labs
- Removed Flutter-specific extensions (will be available in separate `mayr_flutter_extensions` package)

### Removed
- BuildContext extensions (moved to `mayr_flutter_extensions`)
- Widget extensions (moved to `mayr_flutter_extensions`)
- Image widget extensions (moved to `mayr_flutter_extensions`)
- Text widget extensions (moved to `mayr_flutter_extensions`)
- TextStyle extensions (moved to `mayr_flutter_extensions`)
- StatelessWidget extensions (moved to `mayr_flutter_extensions`)
- InkWellManager utility (moved to `mayr_flutter_extensions`)
- `String.copyToClipboard()` method (requires Flutter, moved to `mayr_flutter_extensions`)

---

**Note**: This is a new package publication. For Flutter-specific extensions, use the companion package `mayr_flutter_extensions`.

