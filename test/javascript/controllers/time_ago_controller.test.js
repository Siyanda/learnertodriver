import { describe, test, expect } from 'bun:test'
import { getRelativeTimeString, getNextInterval } from '../../../app/javascript/utils/time_ago.js'
import dayjs from 'dayjs'

describe('getRelativeTimeString', () => {
  test('returns "just now" for recent timestamps', () => {
    const now = new Date().toISOString()
    expect(getRelativeTimeString(now)).toMatch(/just now|seconds? ago/)
  })

  test('returns "a minute ago" for ~1 minute ago', () => {
    const past = dayjs().subtract(1, 'minute').toISOString()
    expect(getRelativeTimeString(past)).toMatch(/minute/)
  })
})

describe('getNextInterval', () => {
  test('returns 1000ms for < 60 seconds', () => {
    expect(getNextInterval(30)).toBe(1000)
  })

  test('returns 60 * 1000ms for < 1 hour', () => {
    expect(getNextInterval(600)).toBe(60_000)
  })

  test('returns 60 * 60 * 1000ms for < 24 hours', () => {
    expect(getNextInterval(5_000)).toBe(3_600_000)
  })

  test('returns null after 24 hours', () => {
    expect(getNextInterval(100_000)).toBe(null)
  })
})
