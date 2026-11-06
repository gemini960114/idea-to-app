// 由各單元的 Markdown 產生 docs/guide/*.md，讓每份文件只有一個來源（各資料夾的 README.md）。
// 由 `npm run docs:dev|docs:build` 自動執行；產生的檔案不進 git。
//
// 連結改寫規則：
//   指向 SOURCES 中的檔案（或資料夾的 README.md） -> ./頁面代號
//   指向 repo 內其他檔案（例如 .pptx）            -> 複製到 docs/public/files/，連到 /files/...
//   外部網址與頁內錨點                             -> 不變
import { copyFileSync, existsSync, mkdirSync, readFileSync, statSync, writeFileSync } from 'node:fs'
import { dirname, join, posix } from 'node:path'
import { fileURLToPath } from 'node:url'

const ROOT = join(dirname(fileURLToPath(import.meta.url)), '..')

const SOURCES = {
  'README.md': '00_course_overview',
  '01-install/README.md': '01_install',
  '02-my-project/README.md': '02_my_project',
  '03-github/README.md': '03_github',
  '04-open-source/README.md': '04_open_source',
  '05-skill-report/README.md': '05_skill_report',
  '06-showcase/README.md': '06_showcase',
  'extra-a-literature/README.md': 'extra_a_literature',
  'extra-b-textbook-notes/README.md': 'extra_b_textbook_notes',
}

// 06 是主線的最後一頁，下一頁不要接到延伸練習
const PAGER = {
  '06-showcase/README.md': { next: false },
}

function frontmatter(source) {
  const pager = PAGER[source]
  if (!pager) return ''
  const lines = Object.entries(pager).map(([key, value]) => `${key}: ${JSON.stringify(value)}`)
  return `---\n${lines.join('\n')}\n---\n\n`
}

function resolveTarget(source, target) {
  if (/^(https?:|mailto:|#)/.test(target)) return undefined
  const [path, hash = ''] = target.split('#')
  const anchor = hash ? `#${hash}` : ''
  const resolved = posix.normalize(posix.join(posix.dirname(source), decodeURI(path))).replace(/\/$/, '')

  if (SOURCES[resolved]) return `./${SOURCES[resolved]}${anchor}`
  if (SOURCES[`${resolved}/README.md`]) return `./${SOURCES[`${resolved}/README.md`]}${anchor}`

  const full = join(ROOT, resolved)
  if (existsSync(full) && statSync(full).isFile()) {
    const dest = join(ROOT, 'docs', 'public', 'files', resolved)
    mkdirSync(dirname(dest), { recursive: true })
    copyFileSync(full, dest)
    return `/files/${resolved}`
  }
  console.warn(`⚠️  ${source}: 找不到連結目標 ${target}`)
  return undefined
}

function convert(source, markdown) {
  return markdown
    // Markdown 連結 ](目標)
    .replace(/\]\(([^)\s]+)\)/g, (match, target) => {
      const next = resolveTarget(source, target)
      return next === undefined ? match : `](${next})`
    })
    // VitePress 不支援 GitHub 的核取方塊語法，改成符號
    .replace(/^(\s*)- \[ \] /gm, '$1- ☐ ')
    .replace(/^(\s*)- \[x\] /gim, '$1- ☑ ')
}

mkdirSync(join(ROOT, 'docs', 'guide'), { recursive: true })
for (const [source, page] of Object.entries(SOURCES)) {
  const markdown = readFileSync(join(ROOT, source), 'utf8')
  writeFileSync(join(ROOT, 'docs', 'guide', `${page}.md`), frontmatter(source) + convert(source, markdown))
  console.log(`synced docs/guide/${page}.md  <-  ${source}`)
}
