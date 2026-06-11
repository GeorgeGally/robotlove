(() => {
  if (window !== window.top) return

  const origin = window.location.origin
  if (origin.startsWith('chrome-extension://') || origin.startsWith('file://')) return

  const SESSION_DISMISSED = new Set()
  const STORAGE_KEY = 'robot-love-persistent-dismiss'
  const COMMENTS_KEY = 'robot-love-comments'
  const SESSION_STATS_KEY = 'robot-love-session-stats'
  const BAR_ID = 'robot-love-bar'
  const FETCH_TIMEOUT = 3000
  const MAX_BYTES = 10240

  async function getPersistentDismissed() {
    try {
      const result = await chrome.storage.local.get(STORAGE_KEY)
      return result[STORAGE_KEY] || []
    } catch {
      return []
    }
  }

  function createBar(content, rawText) {
    const bar = document.createElement('div')
    bar.id = BAR_ID
    bar.style.cssText = `
      position: relative; width: 100%; background: #1a1a1a;
      color: #e0e0e0; font-family: 'Courier New', Courier, monospace;
      font-size: 13px; box-sizing: border-box; z-index: 2147483647;
      line-height: 1.5; padding: 8px 80px 8px 12px;
      white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
      min-height: 32px; display: flex; align-items: center; gap: 8px;
    `

    const prefix = document.createElement('span')
    prefix.style.cssText = `color: #666; flex-shrink: 0;`
    prefix.textContent = '#  '

    const text = document.createElement('span')
    text.style.cssText = `overflow: hidden; text-overflow: ellipsis; white-space: nowrap; flex: 1;`
    text.textContent = content

    const link = document.createElement('a')
    link.href = 'data:text/plain,' + encodeURIComponent(rawText)
    link.target = '_blank'
    link.rel = 'noopener'
    link.textContent = '[raw]'
    link.style.cssText = `
      color: #666; text-decoration: none; flex-shrink: 0;
      font-size: 11px; cursor: pointer;
    `
    link.addEventListener('mouseenter', () => { link.style.color = '#fff' })
    link.addEventListener('mouseleave', () => { link.style.color = '#666' })

    const close = document.createElement('button')
    close.innerHTML = '&times;'
    close.style.cssText = `
      position: absolute; right: 4px; top: 50%; transform: translateY(-50%);
      background: none; border: none; color: #666; font-size: 18px;
      cursor: pointer; width: 24px; height: 24px; display: flex;
      align-items: center; justify-content: center; padding: 0;
      line-height: 1;
    `
    close.addEventListener('mouseenter', () => { close.style.color = '#fff' })
    close.addEventListener('mouseleave', () => { close.style.color = '#666' })
    close.addEventListener('click', (e) => {
      e.stopPropagation()
      SESSION_DISMISSED.add(origin)
      bar.remove()
    })

    bar.appendChild(prefix)
    bar.appendChild(text)
    bar.appendChild(link)
    bar.appendChild(close)
    return bar
  }

  function injectBar(bar) {
    if (document.body) {
      document.body.insertBefore(bar, document.body.firstChild)
      return true
    }
    return false
  }

  async function fetchComments() {
    try {
      const controller = new AbortController()
      const timeout = setTimeout(() => controller.abort(), FETCH_TIMEOUT)

      const response = await fetch(`${origin}/robots.txt`, {
        signal: controller.signal,
      })
      clearTimeout(timeout)

      if (!response.ok) return null

      const text = (await response.text()).slice(0, MAX_BYTES)
      const triggerLine = text.split('\n').find(l => l.trim().startsWith('# \u{1F916}'))
      if (!triggerLine) return null

      let message = triggerLine.replace(/^#\s*\u{1F916}\s*/, '').trim()
      if (message.length > 280) message = message.slice(0, 277) + '...'

      return { message, text }
    } catch {
      return null
    }
  }

  function isAttached(el) {
    return el && el.isConnected
  }

  function defendBar(bar) {
    const observer = new MutationObserver(() => {
      if (!isAttached(bar) && document.body) {
        document.body.insertBefore(bar, document.body.firstChild)
      }
    })
    observer.observe(document.body, { childList: true })
  }

  async function init() {
    const persistent = await getPersistentDismissed()
    if (persistent.includes(origin)) return

    const result = await fetchComments()
    if (!result) return

    const bar = createBar(result.message, result.text)
    injectBar(bar)
    defendBar(bar)

    try {
      await chrome.storage.local.set({ [`${COMMENTS_KEY}-${origin}`]: result.message })
      const stats = await chrome.storage.local.get(SESSION_STATS_KEY)
      const sites = stats[SESSION_STATS_KEY] || []
      if (!sites.includes(origin)) {
        sites.push(origin)
        await chrome.storage.local.set({ [SESSION_STATS_KEY]: sites })
      }
    } catch {}
  }

  window.addEventListener('load', init)
})()
