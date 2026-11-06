import { defineConfig } from 'vitepress'
import { githubSlugify } from '../../scripts/slugify.mjs'

export default defineConfig({
  lang: 'zh-TW',
  title: '從想法到作品：我的 AI 實作課',
  description: '把 AI Studio 的作品搬進 Antigravity，改進、測試、用 GitHub 留下修改紀錄，最後整理成果、上台分享',
  head: [
    ['meta', { name: 'theme-color', content: '#0f7c80' }],
    ['link', { rel: 'icon', href: '/idea-to-app/favicon.ico' }]
  ],
  // 部署在 GitHub Pages 的 /idea-to-app/ 底下
  base: '/idea-to-app/',
  // localhost 是示範用網址
  // /files/ 是 sync-docs 複製的附件；中文檔名會被死連結檢查誤判，檔案實際存在
  ignoreDeadLinks: ['localhostLinks', /^\/files\//],
  // GitHub 風格的標題錨點，README 中的 #錨點 在 GitHub 與網站上都能用
  markdown: {
    anchor: { slugify: githubSlugify }
  },
  themeConfig: {
    nav: [
      { text: '首頁', link: '/' },
      { text: '課程總覽', link: '/guide/00_course_overview' },
      {
        text: '單元',
        items: [
          { text: '01 安裝環境', link: '/guide/01_install' },
          { text: '02 接手自己的專案', link: '/guide/02_my_project' },
          { text: '03 功能改進與 GitHub', link: '/guide/03_github' },
          { text: '04 改造開源作品', link: '/guide/04_open_source' },
          { text: '05 用 Skill 整理成果', link: '/guide/05_skill_report' },
          { text: '06 成果發表', link: '/guide/06_showcase' }
        ]
      }
    ],
    sidebar: [
      {
        text: '🚀 開始',
        items: [
          { text: '📌 課程總覽', link: '/guide/00_course_overview' }
        ]
      },
      {
        text: '📚 講義',
        items: [
          { text: '🧰 01 安裝環境', link: '/guide/01_install' },
          { text: '📦 02 接手自己的專案', link: '/guide/02_my_project' },
          { text: '🔗 03 功能改進與 GitHub', link: '/guide/03_github' },
          { text: '🌀 04 改造開源作品', link: '/guide/04_open_source' },
          { text: '📊 05 用 Skill 整理成果', link: '/guide/05_skill_report' },
          { text: '🎤 06 成果發表', link: '/guide/06_showcase' }
        ]
      },
      {
        text: '🧭 延伸練習',
        items: [
          { text: '📚 延伸 A：AI 整理文獻', link: '/guide/extra_a_literature' },
          { text: '📒 延伸 B：AI 讀課本做筆記', link: '/guide/extra_b_textbook_notes' }
        ]
      }
    ],
    outline: { level: [2, 3], label: '本頁目錄' },
    docFooter: { prev: '上一頁', next: '下一頁' },
    darkModeSwitchLabel: '外觀',
    sidebarMenuLabel: '選單',
    returnToTopLabel: '回到頂端',
    search: {
      provider: 'local'
    },
    footer: {
      message: 'AI 很快，但會出錯，要自己檢查。',
      copyright: 'Copyright © 2026 從想法到作品：我的 AI 實作課'
    }
  }
})
