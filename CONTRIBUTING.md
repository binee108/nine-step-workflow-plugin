# Nine-Step Workflow 플러그인 기여하기

기여에 관심을 가져주셔서 감사합니다! 이 문서는 Nine-Step Workflow 플러그인에 기여하기 위한 가이드라인과 지침을 제공합니다.

## 🎯 기여 방법

- **버그 보고**: 재현 단계와 함께 상세한 버그 보고서 제출
- **기능 제안**: 새로운 에이전트, 스킬 또는 워크플로우 개선 제안
- **문서 개선**: 오타 수정, 설명 명확화, 예제 추가
- **에이전트 추가**: 특정 작업을 위한 새로운 전문화된 에이전트 생성
- **스킬 추가**: 여러 에이전트가 사용할 수 있는 재사용 가능한 스킬 개발
- **이슈 수정**: `good-first-issue` 또는 `help-wanted` 라벨이 붙은 이슈 선택
- **사용 패턴 공유**: 발견한 효과적인 워크플로우 패턴 문서화

## 🚀 시작하기

### 1. Fork 및 Clone

```bash
# GitHub에서 저장소 Fork
# 그런 다음 fork를 clone
git clone https://github.com/YOUR-USERNAME/nine-step-workflow-plugin.git
cd nine-step-workflow-plugin
```

### 2. 개발용 설치

```bash
# 로컬 개발 버전에 대한 심볼릭 링크 생성
ln -s $(pwd) ~/.claude/plugins/nine-step-workflow

# 또는 테스트를 위해 복사
cp -r . ~/.claude/plugins/nine-step-workflow
```

### 3. 변경하기

로컬 저장소에서 파일 편집:
- `agents/` - 에이전트 구현
- `skills/` - 재사용 가능한 스킬 모듈
- `commands/` - 워크플로우 명령어
- `hooks/` - 이벤트 핸들러

### 4. 변경사항 테스트

```bash
# Claude Code에서 플러그인 재로드
claude plugin reload nine-step-workflow

# 샘플 프로젝트로 테스트
cd ~/test-project
claude
# > 변경사항을 대화형으로 테스트
```

### 5. Pull Request 제출

```bash
# 기능 브랜치 생성
git checkout -b feature/your-feature-name

# 변경사항 커밋
git add .
git commit -m "feat: add your feature description"

# Fork에 푸시
git push origin feature/your-feature-name

# GitHub에서 pull request 생성
```

## 📋 개발 가이드라인

### 에이전트 개발

**파일 구조:**
```markdown
---
name: agent-name
description: 간단한 설명 (1-2문장)
tools: Read, Write, Edit, Grep, Glob, Bash
model: sonnet  # 또는 haiku
---

# Agent Name - 역할 제목

## 🎭 에이전트 페르소나
**아이콘**: 🔧
**직무**: 전문 직함
**전문 분야**: 특정 기술
**역할**: 이 에이전트가 하는 일
**목표**: 궁극적인 목적

## 🌍 언어 처리
[언어 지침]

## 🧰 스킬 및 조건부 로딩
[이 에이전트가 사용하는 스킬]

## 🎯 9단계 워크플로우에서의 역할
[이 에이전트가 처리하는 단계]

## 핵심 임무
[상세한 책임]

## 출력 형식
[예상 출력]

## 성공 기준
[성공 평가 방법]
```

**모범 사례:**
- 명확하고 행동 지향적인 이름 사용 (예: `database-migrator`, `api-designer`)
- 필요한 정확한 도구 지정 (불필요한 도구 접근 최소화)
- 적절한 모델 선택 (복잡한 추론은 Sonnet, 실행은 Haiku)
- 조건부로 스킬 로드 (필요할 때만)
- 문서에 구체적인 예제 포함
- 명확한 성공 기준 정의

**모델 선택:**
```
Sonnet: 아키텍처, 설계, 복잡한 결정, 보안 분석
Haiku: 규칙 준수, 반복 작업, 간단한 실행
```

### 스킬 개발

**디렉토리 구조:**
```
skills/
└── your-skill/
    └── SKILL.md
```

**파일 구조:**
```markdown
---
name: your-skill
description: 간단한 설명
applies_to: ["agent1", "agent2"]  # 이 스킬을 사용하는 에이전트
---

# Skill Name

## 🎯 목적
[이 스킬이 해결하는 문제]

## 📋 사용 시기
[특정 시나리오]

## 🛠️ 사용 방법
[단계별 지침]

## 💡 예제

### 예제 1: [시나리오]
[코드 또는 지침]

### 예제 2: [시나리오]
[코드 또는 지침]

## ⚠️ 일반적인 함정
[피해야 할 것]

## 🔗 관련 스킬
[이것을 보완하는 다른 스킬]
```

**모범 사례:**
- 스킬을 집중적이고 재사용 가능하게 만들기
- 2-3개의 구체적인 예제 제공
- 일반적인 함정 문서화
- 관련 스킬에 링크
- 해당하는 경우 메트릭 포함 (예: "30초 vs 5분")

### 명령어 개발

**파일 구조:**
```markdown
---
description: 간단한 명령어 설명
usage: /command-name [arguments]
---

# 명령어 구현

[명령어 프롬프트 및 지침]
```

**모범 사례:**
- 명확하고 행동 지향적인 명령어 이름
- 일반적인 인수 지원 (resume, rollback 등)
- 도움이 되는 오류 메시지 제공
- 설명에 사용 예제 포함

### Hook 개발

**`hooks/hooks.json`에 추가:**
```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "ToolName",
        "hooks": [
          {
            "type": "notification",
            "message": "도움이 되는 메시지"
          }
        ]
      }
    ]
  }
}
```

**Hook 타입:**
- `PreToolUse`: 도구 실행 전
- `PostToolUse`: 도구 실행 후
- `UserPromptSubmit`: 사용자 입력 시

## 🧪 테스트 가이드라인

### 수동 테스트 체크리스트

PR을 제출하기 전에 테스트:

**에이전트의 경우:**
- [ ] 호출 시 에이전트가 올바르게 활성화됨
- [ ] 에이전트가 필요한 스킬을 성공적으로 로드함
- [ ] 에이전트가 예상 출력 형식을 생성함
- [ ] 에이전트가 오류를 우아하게 처리함
- [ ] 에이전트가 다음 워크플로우 단계로 작업을 전달함

**스킬의 경우:**
- [ ] 스킬이 오류 없이 로드됨
- [ ] 문서의 예제가 올바르게 작동함
- [ ] 여러 에이전트가 스킬을 사용할 수 있음
- [ ] 스킬이 명확한 오류 메시지를 제공함

**명령어의 경우:**
- [ ] 명령어가 인수를 올바르게 파싱함
- [ ] 명령어가 예상 워크플로우를 실행함
- [ ] 명령어가 누락/잘못된 인수를 처리함
- [ ] 명령어가 도움이 되는 사용 정보를 제공함

**Hook의 경우:**
- [ ] Hook이 올바른 이벤트에서 트리거됨
- [ ] Hook 메시지가 명확하고 실행 가능함
- [ ] Hook이 워크플로우를 방해하지 않음

### 테스트 프로젝트

일반적인 시나리오에 대한 테스트 프로젝트 생성:

```bash
test-projects/
├── simple-feature/      # 단일 단계 기능
├── complex-feature/     # 다중 단계 기능
├── bug-fix/            # 버그 조사 및 수정
└── refactoring/        # 코드 재구조화
```

## 📝 커밋 메시지 형식

[Conventional Commits](https://www.conventionalcommits.org/) 준수:

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

**타입:**
- `feat`: 새 기능 (에이전트, 스킬, 명령어)
- `fix`: 버그 수정
- `docs`: 문서 변경
- `refactor`: 코드 리팩토링
- `test`: 테스트 추가 또는 수정
- `chore`: 유지보수 작업

**예제:**
```
feat(agent): database-migrator 에이전트 추가

롤백 지원 및 검증이 있는 데이터베이스 스키마 마이그레이션을 위한
전문화된 에이전트를 구현합니다.

feat(skill): sql-injection-prevention 스킬 추가

SQL 인젝션 취약점을 방지하기 위한 패턴 및 검사를 제공합니다.

docs(readme): worktree 오류에 대한 문제 해결 섹션 추가

fix(command): workflow-resume에서 누락된 계획 문서 처리

계획 문서가 삭제된 경우를 우아하게 처리합니다.
```

## 📚 문서 표준

### 코드 주석

**에이전트 파일:**
```markdown
# 명확한 섹션 헤더
## 하위 섹션 구성
**굵게** 중요한 개념
`코드` 기술 용어
```

**스킬 파일:**
```markdown
# 제목은 스킬 이름과 일치
## 목적 (왜 존재하는지)
## 사용 시기 (특정 시나리오)
## 사용 방법 (단계별)
## 예제 (2-3개의 구체적인 예제)
```

### README 업데이트

기능 추가 시 업데이트:
- 설명이 있는 기능 목록
- 에이전트/스킬/명령어 테이블
- 사용 예제 (해당하는 경우)
- 설정 옵션 (해당하는 경우)

## 🔍 코드 리뷰 프로세스

### 기여자를 위해

1. **자체 리뷰**: 먼저 자신의 코드 확인
2. **문서화**: 관련 문서 업데이트
3. **테스트**: 실제 시나리오로 수동 테스트
4. **커밋 메시지**: 컨벤셔널 커밋 형식 준수
5. **PR 설명**: 무엇을, 왜, 어떻게 설명

### 리뷰어를 위해

다음 사항 검토:
- **기능**: 의도한 대로 작동하는가?
- **코드 품질**: 깔끔하고, 읽기 쉽고, 유지보수 가능한가?
- **문서화**: 잘 문서화되어 있는가?
- **일관성**: 기존 패턴과 일치하는가?
- **성능**: 성능 문제가 있는가?
- **보안**: 보안 관련 사항이 있는가?

## 🏷️ 이슈 라벨

다음 라벨을 사용합니다:

- `bug`: 무언가 작동하지 않음
- `feature`: 새 기능 요청
- `enhancement`: 기존 기능 개선
- `documentation`: 문서 개선
- `good-first-issue`: 초보자에게 좋음
- `help-wanted`: 커뮤니티 도움 환영
- `priority:high`: 높은 우선순위
- `priority:medium`: 중간 우선순위
- `priority:low`: 낮은 우선순위
- `agent`: 에이전트 관련
- `skill`: 스킬 관련
- `command`: 명령어 관련
- `hook`: Hook 관련

## 🎯 로드맵 기여

로드맵 항목 작업을 원하시나요? 확인:
- [CHANGELOG.md](./CHANGELOG.md) - 계획된 버전
- [GitHub Projects](https://github.com/your-org/nine-step-workflow-plugin/projects) - 작업 보드
- [GitHub Discussions](https://github.com/your-org/nine-step-workflow-plugin/discussions) - 기능 토론

## 🤝 커뮤니티 가이드라인

### 행동 강령

- 존중하고 포용적이어야 함
- 건설적인 피드백 제공
- 사람이 아닌 문제에 집중
- 좋은 의도를 가정
- 초보자가 배우도록 도움

### 소통

- **GitHub Issues**: 버그 보고, 기능 요청
- **GitHub Discussions**: 아이디어, 질문, 일반 토론
- **Pull Requests**: 명확한 설명이 있는 코드 기여
- **이메일**: 보안 문제는 security@example.com

## 🆘 도움 받기

막혔나요? 도움을 받는 방법:

1. **문서 읽기**: README, CHANGELOG 및 스킬/에이전트 문서 확인
2. **이슈 검색**: 누군가 이미 물어봤을 수 있음
3. **토론에서 질문**: 커뮤니티가 도울 수 있음
4. **이슈 생성**: 버그 또는 누락된 기능인 경우

## 📊 기여 인정

기여자는 다음과 같이 인정받습니다:
- 릴리스 노트에 나열됨
- CHANGELOG.md에 언급됨
- GitHub 기여자 그래프
- 주요 기여에 대한 특별 인정

## 🔐 보안 이슈

보안 취약점에 대해 공개 이슈를 열지 **마세요**.

대신:
1. security@example.com으로 이메일 보내기
2. 상세한 설명 포함
3. 재현 단계 제공
4. 공개 전에 수정을 위해 90일 허용

## 📜 라이선스

기여함으로써 귀하의 기여가 MIT 라이선스에 따라 라이선스됨에 동의합니다.

---

## 질문이 있으신가요?

- **문서**: [Wiki](https://github.com/your-org/nine-step-workflow-plugin/wiki)
- **토론**: [GitHub Discussions](https://github.com/your-org/nine-step-workflow-plugin/discussions)
- **이메일**: contribute@example.com

Nine-Step Workflow 플러그인에 기여해주셔서 감사합니다! 🎉
