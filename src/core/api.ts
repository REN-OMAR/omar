/* eslint-disable @typescript-eslint/restrict-plus-operands */
/* eslint-disable @typescript-eslint/restrict-template-expressions */
import axios from 'axios'
// import { writeFileSync } from 'fs'
import { IRespWrap } from '../model/club'
const _config = {
	timeout: 5000,
	headers: {
		// eslint-disable-next-line @typescript-eslint/naming-convention
		// 'Referer': 'https://www.ea.com',
		// eslint-disable-next-line @typescript-eslint/naming-convention
		// 'User-Agent': null
		// 'timeout':5000
	}
} as const
const API_URL = 'https://proclubs.ea.com/api/fifa/'
export type TPlatformType = ('ps4' | 'pc' | 'xboxone' | 'ps5' | 'xbox-series-xs')

export const isPlatformType = (pType: unknown): pType is TPlatformType =>
	pType === 'ps4' || pType === 'pc' || pType === 'xboxone' || pType === 'ps5' || pType === 'xbox-series-xs'
// let platformType: TPlatformType | undefined
// export const FIFA19URL = 'https://www.easports.com/iframe/fifa19proclubs/api/platforms'

// let platformTypeFifa19: 'ps4' | 'pc' | 'xboxone' | undefined

// function* values(obj: Record<string, unknown>) { for (const prop of Object.keys(obj)) { yield obj[prop] } }
function* values2<T extends Record<string, any>>(obj: T) { for (const prop of Object.keys(obj)) { yield obj[prop] } }


/* export const newPlatformTypefifa19 = ( platform:'ps4' | 'pc' | 'xboxone') => platformTypeFifa19 = platform

export const getfifa19 = async (route: string) => {
	try {
		const resp = await axios.get(`${FIFA19URL}/${platformTypeFifa19}/${route}`)
		return Array.from(values(resp.data))[0]
	} catch (e) {console.log(e)}
}{ params: { answer: 42 } } */


const _getExt = async <T>(platform: TPlatformType, route: string, params: Record<string, unknown>) => {
	try {
		params = { ...params, platform }
		// console.log(route, params, { ..._config, ...{ params } })
		const resp = await axios.get<IRespWrap<T>>(`${API_URL}${route}`, { ..._config, params })
		// eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
		const r: T[] = Array.from(values2(resp.data))
		console.log((resp.request as unknown as Record<string, string>).path)
		return r
	} catch (e) { /* if (e instanceof Error) */ { console.log(e) /* */ } }
}

const _get = async <T>(platform: TPlatformType, route: string, params: Record<string, unknown>) =>
	(await _getExt<T>(platform, route, params))?.[0]
export const get = (platform: TPlatformType, route: string) => _get(platform, route, {})
export const getExt = <T>(platform: TPlatformType, route: string) => _getExt<T>(platform, route, {})
export const getParam = <T>(platform: TPlatformType, route: string, params: Record<string, unknown>) =>
	_get<T>(platform, route, params)
export const getParamExt = <T>(platform: TPlatformType, route: string, params: Record<string, unknown>) => {
	params = { ...params }
	return _getExt<T>(platform, route, params)
}
export const getNoParam = <T>(platform: TPlatformType, route: string) => _getExt<T>(platform, route, {})

