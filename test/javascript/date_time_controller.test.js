import { describe, expect, test } from "bun:test"
import dayjs from "dayjs"
import {
  getNextInterval,
  getRelativeTimeString,
} from "../../app/components/utils/date_time/controller"

describe("getRelativeTimeString", () => {
  test("returns a relative time for a past timestamp", () => {
    const fiveMinutesAgo = dayjs().subtract(5, "minute").toISOString()

    expect(getRelativeTimeString(fiveMinutesAgo)).toBe("5 minutes ago")
  })

  test("returns a relative time for a future timestamp", () => {
    const inOneHour = dayjs().add(1, "hour").toISOString()

    expect(getRelativeTimeString(inOneHour)).toBe("in an hour")
  })
})

describe("getNextInterval", () => {
  test("refreshes every second for ages under a minute", () => {
    expect(getNextInterval(0)).toBe(1000)
    expect(getNextInterval(59)).toBe(1000)
  })

  test("refreshes every minute for ages under an hour", () => {
    expect(getNextInterval(60)).toBe(60 * 1000)
    expect(getNextInterval(3599)).toBe(60 * 1000)
  })

  test("refreshes every hour for ages under a day", () => {
    expect(getNextInterval(3600)).toBe(60 * 60 * 1000)
    expect(getNextInterval(86399)).toBe(60 * 60 * 1000)
  })

  test("stops refreshing for ages of a day or more", () => {
    expect(getNextInterval(86400)).toBeNull()
    expect(getNextInterval(100000)).toBeNull()
  })
})
