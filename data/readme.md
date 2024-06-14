files generated with

```typescript
writeFileSync(
			(resp.request as Record<string, string>).path
				.replaceAll('/', '_')
				.replaceAll('?', '-param-') + '.json',
			JSON.stringify({
				...resp.data,
				...{
					path: (resp.request as Record<string, unknown>).path,
					r
				}
			})
		)
```