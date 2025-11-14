# Claude Code용 Nine-Step Workflow 플러그인

> 전문화된 에이전트, 품질 게이트, Git Worktree 통합을 갖춘 프로덕션 수준의 개발 워크플로우

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/your-org/nine-step-workflow-plugin)

## 🎯 개요

Nine-Step Workflow 플러그인은 Claude Code를 12개의 전문화된 에이전트, 17개의 재사용 가능한 스킬, 그리고 체계적인 계획, 구현, 리뷰, 테스트, 배포를 통해 프로덕션 수준의 코드를 보장하는 입증된 9단계 워크플로우를 갖춘 완전한 개발팀으로 변환합니다.

### 왜 이 플러그인인가?

- **체계적인 개발**: 더 이상 임기응변식 코딩은 없습니다. 모든 기능은 입증된 9단계 워크플로우를 따릅니다
- **품질 게이트**: 다단계 리뷰 단계가 프로덕션에 도달하기 전에 문제를 포착합니다
- **전문화된 에이전트**: 12개의 전문 에이전트가 특정 작업을 처리합니다 (계획, 코딩, 리뷰, 테스트, 문서화)
- **Git Worktree 통합**: 브랜치 전환의 혼란 없이 기능 개발을 격리합니다
- **재사용 가능한 스킬**: 17개의 스킬이 일반적인 과제에 대한 일관된 접근 방식을 제공합니다
- **단계별 분해**: 대규모 기능을 테스트 가능한 1-3시간 단계로 나눕니다

## ✨ 기능

### 🤖 12개의 전문화된 에이전트

| 에이전트 | 역할 | 책임 |
|-------|------|----------------|
| **project-planner** | 계획 | 요구사항 분석, 상세 구현 계획 생성 |
| **plan-reviewer** | 품질 게이트 | 유지보수성, 위험, 아키텍처에 대한 계획 검증 |
| **backend-developer** | 구현 | 서버 사이드 로직, API, 데이터베이스 작업 구축 |
| **frontend-developer** | 구현 | UI/UX 생성, 클라이언트 사이드 로직, API 통합 |
| **code-reviewer** | 품질 게이트 | 코드 품질, 보안, 성능 리뷰 |
| **documentation-manager** | 문서화 | 명확한 문서, 코드 주석, 기능 가이드 작성 |
| **documentation-reviewer** | 품질 게이트 | 문서 명확성 및 정확성 검증 |
| **feature-tester** | 테스트 | 테스트 실행, 테스트 케이스 작성, 기능 검증 |
| **test-reviewer** | 품질 게이트 | 테스트 커버리지 및 전략 확인 |
| **issue-manager** | 프로젝트 관리 | 이슈 추적, 작업 우선순위 지정, GitHub 이슈 관리 |
| **git-worktree-manager** | 인프라 | Git worktree, 커밋, 병합, 정리 관리 |
| **merge-conflict-resolver** | 충돌 해결 | 병합 충돌 체계적으로 분석 및 해결 |

### 🎓 17개의 재사용 가능한 스킬

**핵심 스킬** (모든 에이전트가 사용):
- `tag-based-search` - grep과 기능 태그를 사용한 빠른 코드 발견
- `interactive-questions` - 효과적인 명확화 질문 구성
- `language-conventions` - 다국어 프로젝트 가이드라인
- `trust-principles` - TRUST 품질 프레임워크 (Test, Readable, Unified, Secured, Trackable)

**계획 및 워크플로우 스킬**:
- `nine-step-workflow` - 예제가 포함된 완전한 워크플로우 가이드
- `phase-decomposition` - 기능을 1-3시간 단계로 분해
- `risk-assessment` - 기술, 운영, 보안, 비즈니스 위험 평가
- `code-minimization` - 메트릭으로 모든 새 코드 정당화
- `plan-document-lifecycle` - 계획 문서를 생성부터 정리까지 관리

**Git 및 테스트 스킬**:
- `git-workflow-policy` - Git 작업, 커밋, 4단계 정리
- `worktree-path-policy` - 잘못된 코드베이스에 대한 실수 방지
- `test-file-management` - 영구 vs 임시 테스트 조직

**아키텍처 및 품질 스킬**:
- `architecture-principles` - SSOT, DRY, 안티 스파게티 패턴
- `security-checklist` - RCE, SQL 인젝션, 일반적인 취약점 방지
- `quality-gates` - 4단계 승인 시스템 (APPROVED, WITH_CONDITIONS, NEEDS_REVISION, REJECTED)
- `agent-model-selection` - 작업 복잡성에 따라 Sonnet vs Haiku 선택
- `documentation-draft` - 구조화된 문서 템플릿

### 🔄 9단계 워크플로우

모든 기능 개발은 이 입증된 워크플로우를 따릅니다:

```
1단계: 계획           → project-planner가 상세 구현 계획 생성
2단계: 계획 리뷰      → plan-reviewer가 접근법과 위험 검증
2.5단계: 사용자 승인 ⭐ → 구현 시작 전에 사용자 승인
  ↓ (git worktree 생성)
3단계: 코딩           → backend/frontend-developer가 worktree에서 구현
4단계: 코드 리뷰      → code-reviewer가 품질, 보안, 성능 확인
5단계: 문서화         → documentation-manager가 문서 및 주석 작성
6단계: 문서 리뷰      → documentation-reviewer가 문서 검증
7단계: 테스트         → feature-tester가 포괄적인 테스트 실행
8단계: 테스트 리뷰    → test-reviewer가 커버리지 및 전략 확인
9단계: 커밋           → git-worktree-manager가 커밋 및 병합
```

### 📦 4가지 필수 명령어

- `/workflow-exec` - 기능 또는 버그 수정을 위한 완전한 9단계 워크플로우 실행
- `/workflow-resume` - 마지막으로 완료된 단계에서 워크플로우 재개
- `/workflow-rollback` - 이전 단계 또는 단계로 롤백
- `/plugin-update` - GitHub에서 플러그인 업데이트 확인 및 적용

## 🚀 빠른 시작

### 설치

1. **Claude Code CLI를 통한 설치** (권장):
```bash
claude plugin install nine-step-workflow
```

2. **수동 설치**:
```bash
# 저장소 복제
git clone https://github.com/your-org/nine-step-workflow-plugin.git

# Claude Code 플러그인 디렉토리에 설치
cp -r nine-step-workflow-plugin ~/.claude/plugins/nine-step-workflow
```

3. **설치 확인**:
```bash
claude plugin list
# 표시되어야 함: nine-step-workflow v1.1.0
```

### 플러그인 업데이트

최신 기능 및 버그 수정으로 플러그인을 최신 상태로 유지하세요:

1. **자동 업데이트** (권장):
```
/plugin-update
```

Claude는:
- 최신 버전을 GitHub에서 확인합니다
- 업데이트가 있으면 릴리스 노트를 보여줍니다
- 확인 후 플러그인을 업데이트합니다

2. **수동 업데이트**:
```bash
cd ~/.claude/plugins/nine-step-workflow
git pull origin main
```

3. **업데이트만 확인**:
```bash
cd ~/.claude/plugins/nine-step-workflow
./scripts/check-version.sh --check-only
```

플러그인은 7일마다 자동으로 업데이트를 확인하고 새 버전이 있으면 알려줍니다.

### 첫 사용

1. **새 기능 시작**:
```
안녕 Claude, 내 앱에 사용자 인증을 추가해야 해. 도와줄 수 있어?
```

Claude는 자동으로:
- 요구사항 분석을 위해 `project-planner` 호출
- 단계별 상세 구현 계획 생성
- 검증을 위해 `plan-reviewer`에 계획 제출
- 구현 시작 전에 승인 요청

2. **워크플로우 명령어 사용** (명시적 제어):
```
/workflow-exec "JWT 토큰으로 사용자 인증 추가"
```

3. **중단된 작업 재개**:
```
/workflow-resume
```

## 📖 사용 예제

### 예제 1: 간단한 기능 추가

```
사용자: 설정 페이지에 다크 모드 토글 추가

워크플로우:
1단계: project-planner가 3단계 계획 생성
  - 1단계: 테마 컨텍스트 및 상태 관리 (2시간)
  - 2단계: UI 토글 컴포넌트 (1.5시간)
  - 3단계: 기존 컴포넌트에 테마 적용 (2시간)

2단계: plan-reviewer가 접근법 검증
2.5단계: 사용자 승인 ✅

(git worktree 생성: .worktree/dark-mode-toggle/)

1단계:
  3단계: backend-developer가 테마 컨텍스트 구현
  4단계: code-reviewer가 검증
  5-6단계: 문서화 추가 및 리뷰
  7-8단계: 테스트 생성 및 리뷰
  9단계: Worktree에 커밋

2-3단계: (3-9단계 반복)

최종: git-worktree-manager가 main에 병합 및 정리
```

### 예제 2: 조사를 통한 버그 수정

```
사용자: 사용자들이 주문이 제대로 처리되지 않는다고 보고함

워크플로우:
1단계: project-planner가 조사
  - tag-based-search를 사용하여 @FEAT:order-processing 찾기
  - 로그 및 코드 분석
  - 주문 검증에서 경쟁 조건 식별

2단계: plan-reviewer가 수정 접근법 검증
2.5단계: 사용자 승인 ✅

3단계: backend-developer가 잠금으로 수정 구현
4단계: code-reviewer가 유사한 경쟁 조건 확인
5-6단계: 문서 업데이트
7단계: feature-tester가 회귀 테스트 생성
8단계: test-reviewer가 테스트가 재발을 방지하는지 검증
9단계: 커밋 및 병합
```

### 예제 3: 여러 단계가 있는 대규모 기능

```
사용자: 실시간 알림 시스템 구현

워크플로우:
1단계: project-planner가 5단계로 분해
  1단계: 알림용 데이터베이스 스키마 (2시간)
  2단계: 백엔드 알림 서비스 (3시간)
  3단계: WebSocket 인프라 (2.5시간)
  4단계: 프론트엔드 알림 컴포넌트 (2시간)
  5단계: 통합 및 테스트 (2시간)

각 단계는 독립적으로 완전한 9단계 워크플로우를 따름
사용자는 각 단계 후에 승인/거부 가능
초기 단계는 후속 단계 시작 전에 테스트 가능
```

## ⚙️ 설정

### 프로젝트별 커스터마이징

프로젝트 루트에 `CLAUDE.md` 파일을 생성하여 커스터마이즈:

```markdown
# MyProject용 Claude Code 가이드라인

## 프로젝트별 규칙

- 항상 TypeScript strict 모드 사용
- API 응답은 JSON:API 사양을 따라야 함
- 데이터베이스 마이그레이션은 되돌릴 수 있어야 함
- 모든 사용자 입력은 Zod 스키마로 검증해야 함

## 기술 스택

- 백엔드: Node.js + Express + PostgreSQL
- 프론트엔드: React + TypeScript + TailwindCSS
- 테스트: Jest + React Testing Library

## 코딩 표준

- 최대 함수 길이: 50줄
- 최대 파일 길이: 300줄
- 함수형 컴포넌트만 사용
```

### 플레이스홀더 및 변수

플러그인은 `CLAUDE.md`에서 정의해야 하는 다음 일반 플레이스홀더를 사용합니다:

- `{{PROJECT_NAME}}` - 프로젝트 이름
- `{{TECH_STACK}}` - 사용된 기술
- `{{CODING_STANDARDS}}` - 코딩 규칙
- `{{TEST_FRAMEWORK}}` - 테스트 도구
- `{{DEPLOYMENT_PROCESS}}` - 배포 방법

예제:
```markdown
## 프로젝트 정보
- 프로젝트 이름: MyAwesomeApp
- 기술 스택: Python Flask + React + PostgreSQL
- 코딩 표준: PEP 8, ESLint Standard
```

### 언어 설정

`CLAUDE.md`에서 선호하는 언어 설정:

```markdown
## 언어 설정

- conversation_language: Korean  # 또는 English, Japanese 등
- code_language: English  # 코드/주석은 항상 영어
```

## 📐 아키텍처

### 작동 방식

```
사용자 요청
    ↓
Conductor (Claude)가 요청 분석
    ↓
적절한 에이전트 선택 (예: project-planner)
    ↓
에이전트가 필요한 스킬 로드
    ↓
에이전트가 스킬을 사용하여 작업 실행
    ↓
에이전트가 구조화된 결과 반환
    ↓
Conductor가 다음 에이전트로 라우팅 (품질 게이트)
    ↓
워크플로우가 모든 9단계를 계속 진행
```

### 에이전트-스킬 관계

```
project-planner 에이전트
├── 사용: tag-based-search 스킬 (기존 코드 찾기)
├── 사용: phase-decomposition 스킬 (단계로 분해)
├── 사용: code-minimization 스킬 (새 코드 정당화)
├── 사용: risk-assessment 스킬 (위험 식별)
└── 사용: interactive-questions 스킬 (요구사항 명확화)

code-reviewer 에이전트
├── 사용: architecture-principles 스킬 (SSOT, DRY)
├── 사용: security-checklist 스킬 (취약점 스캔)
├── 사용: quality-gates 스킬 (승인 기준)
└── 사용: trust-principles 스킬 (TRUST 프레임워크)
```

## 🎓 모범 사례

### 1. 항상 계획으로 시작

코드로 바로 들어가기 전에 `project-planner`가 분석하도록 하세요:
```
❌ 나쁨: "로그인 함수를 JWT를 사용하도록 변경해"
✅ 좋음: "인증을 세션에서 JWT로 전환해야 해. 계획할 수 있어?"
```

### 2. 품질 게이트 신뢰

리뷰 단계를 건너뛰지 마세요:
```
❌ 나쁨: 코드 리뷰 없이 병합
✅ 좋음: 진행하기 전에 code-reviewer가 검증하도록 하기
```

### 3. 단계별 분해 사용

대규모 기능을 테스트 가능한 단계로 나누세요:
```
❌ 나쁨: "전체 전자상거래 결제를 한 단계에 구현"
✅ 좋음:
  1단계: 장바구니 요약 및 검증 (2시간)
  2단계: 결제 통합 (2.5시간)
  3단계: 주문 확인 (1.5시간)
```

### 4. 태그 기반 검색 활용

빠른 코드 발견을 위해 기능 태그 사용:
```python
# @FEAT:user-auth @COMP:service @TYPE:core
class AuthService:
    def authenticate(self, credentials):
        # ...
```

### 5. 결정 문서화

`plan-document-lifecycle` 사용:
```
.plan/
├── user-auth_plan.md        # 활성 개발
├── dark-mode_plan.md         # 활성 개발
└── (병합 후 삭제)            # 자동 정리
```

## 🔍 문제 해결

### 문제: 에이전트가 기존 코드를 찾지 못함

**해결책**: 코드에 기능 태그가 있는지 확인:
```python
# @FEAT:feature-name @COMP:service @TYPE:core
```

`docs/FEATURE_CATALOG.md`를 기능 설명으로 업데이트하세요.

### 문제: 계획이 너무 모호하고 구현이 불명확함

**해결책**: 더 자세한 내용 요청:
```
"계획이 너무 상위 수준이야. project-planner가 파일 수준의 세부 정보를 제공할 수 있어?"
```

또는 계획에서 "상세 가이드" 접근법을 지정하세요.

### 문제: 리뷰가 계속 거부됨

**해결책**: 특정 거부 이유 확인:
- plan-reviewer: 보통 아키텍처 또는 코드 최소화 문제
- code-reviewer: 보통 보안 또는 유지보수성 문제
- test-reviewer: 보통 커버리지 또는 전략 문제

리뷰어에게 특정 우려 사항을 설명하도록 요청하세요.

### 문제: Worktree 경로 오류

**해결책**: conductor가 worktree 경로를 전달하는지 확인:
```
"worktree에서 작업: .worktree/feature-name/"
```

`git worktree list`로 확인하세요.

## 🤝 기여

기여를 환영합니다! 가이드라인은 [CONTRIBUTING.md](./CONTRIBUTING.md)를 참조하세요.

### 개발 설정

```bash
# 저장소 복제
git clone https://github.com/your-org/nine-step-workflow-plugin.git
cd nine-step-workflow-plugin

# 로컬에서 테스트
cp -r . ~/.claude/plugins/nine-step-workflow

# 에이전트, 스킬 또는 명령어 변경

# 변경사항 테스트
claude plugin reload nine-step-workflow
```

### 새 에이전트 추가

1. `agents/`에 에이전트 파일 생성:
```markdown
---
name: your-agent
description: 간단한 설명
tools: Read, Write, Edit
model: sonnet
---

# Your Agent Name
[에이전트 구현...]
```

2. 이 README의 에이전트 테이블 업데이트
3. Pull request 제출

### 새 스킬 추가

1. `skills/your-skill/`에 스킬 디렉토리 생성
2. frontmatter와 함께 `SKILL.md` 추가:
```markdown
---
name: your-skill
description: 간단한 설명
---

# Your Skill
[스킬 구현...]
```

3. 관련 에이전트에서 참조
4. Pull request 제출

## 📊 메트릭 및 분석

워크플로우 효과 추적:

- **계획 정확도**: 계획이 예상대로 완료되는 빈도
- **리뷰 거부율**: 품질 게이트에서 거부된 아티팩트 비율
- **단계 완료 시간**: 단계당 실제 vs 예상 시간
- **코드 변동**: 리뷰 후 변경된 라인
- **테스트 커버리지**: 테스트로 커버된 코드 비율

## 🗺️ 로드맵

### v1.1.0 (다음 릴리스)
- [ ] 성능 메트릭 대시보드
- [ ] 커스텀 품질 게이트 규칙
- [ ] CI/CD 파이프라인과의 통합
- [ ] 에이전트 성능 분석

### v1.2.0
- [ ] 다국어 지원 (영어/한국어 이상 확장)
- [ ] 커스텀 에이전트 템플릿
- [ ] 워크플로우 시각화
- [ ] 테스트 실패 시 자동 롤백

### v2.0.0
- [ ] 커스텀 에이전트용 플러그인 마켓플레이스
- [ ] 팀 협업 기능
- [ ] 엔터프라이즈 SSO 통합
- [ ] 고급 충돌 해결 AI

## 📄 라이선스

MIT 라이선스 - 자세한 내용은 [LICENSE](./LICENSE) 참조

## 🙏 감사의 말

- 선도적인 기술 회사의 프로덕션 워크플로우에서 영감을 받음
- Claude Code의 강력한 에이전트 프레임워크를 기반으로 구축
- 커뮤니티 피드백이 9단계 워크플로우를 형성함

## 📞 지원

- **문서**: [전체 문서](https://github.com/your-org/nine-step-workflow-plugin/wiki)
- **이슈**: [GitHub Issues](https://github.com/your-org/nine-step-workflow-plugin/issues)
- **토론**: [GitHub Discussions](https://github.com/your-org/nine-step-workflow-plugin/discussions)
- **이메일**: support@example.com

## 🌟 스타 기록

이 플러그인이 당신의 개발 워크플로우에 도움이 된다면 저장소에 스타를 주세요!

---

**Nine-Step Workflow 팀이 ❤️로 만들었습니다**

[시작하기](#빠른-시작) | [예제 보기](#사용-예제) | [문서 읽기](https://github.com/your-org/nine-step-workflow-plugin/wiki)
