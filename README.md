# NoteDox

NoteDox는 새롭게 만난 단어, 표현, 용어, 예문, 기억 단서를 차곡차곡 모아두는 개인 학습 노트입니다.

이름은 Leedox에서 이어진 "Dox" 키워드를 중심에 둡니다. 문서를 만들고, 보관하고, 다시 찾아보는 감각을 담아 사용자가 자신만의 어휘 아카이브를 쌓아갈 수 있게 하는 것이 목표입니다.

## Concept

NoteDox는 커뮤니티 게시판이나 단순 CRUD 앱이 아니라, 조용히 누적되는 vocabulary notebook입니다.

- 새로 발견한 word/phrase를 item으로 저장합니다.
- item을 group으로 묶어 주제별로 정리합니다.
- 검색과 필터로 필요한 표현을 빠르게 다시 찾습니다.
- memo/note를 덧붙여 뜻, 예문, 뉘앙스, 기억법을 함께 남깁니다.
- 한국어 UX를 기본으로 하되, NoteDox, Words & phrases, Notes 같은 영어 표현은 브랜드 정체성을 강화할 때 선택적으로 사용합니다.

## Core Flow

1. 로그인합니다.
2. 새 item을 작성합니다.
3. item을 group에 배치합니다.
4. 목록에서 검색하거나 group으로 필터링합니다.
5. memo/note를 추가하며 학습 맥락을 보완합니다.

## Product Tone

NoteDox의 화면과 문구는 차분한 학습 노트에 가까워야 합니다.

- 사용자에게는 item, word/phrase, group, memo/note라는 표현을 사용합니다.
- 내부 Rails 모델명인 Post, Comment는 코드 안에서만 유지합니다.
- 빈 상태는 다음 행동을 자연스럽게 안내합니다.
- 모든 CRUD 화면은 명확한 주요 액션과 돌아갈 경로를 제공합니다.

## Tech Stack

- Ruby on Rails 8.1
- Ruby 3.3
- SQLite3
- Devise
- Hotwire, Turbo, Stimulus
- ERB templates with Tailwind CSS
- Minitest

## Development

```bash
bin/rails db:prepare
bin/rails server
```

Run the test suite:

```bash
DISABLE_SPRING=1 bin/rails test
```
