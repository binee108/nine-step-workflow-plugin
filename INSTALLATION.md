# 설치 가이드

Nine-Step Workflow 플러그인 설치 및 구성을 위한 완전한 가이드입니다.

## 📋 사전 요구사항

- **Claude Code**: 버전 1.0.0 이상
- **Git**: 버전 2.25 이상 (worktree 기능용)
- **운영 체제**: macOS, Linux, 또는 WSL이 있는 Windows

## 🚀 설치 방법

### 방법 1: Claude Code CLI (권장)

```bash
# Claude Code 마켓플레이스에서 설치
claude plugin install nine-step-workflow

# 설치 확인
claude plugin list

# 예상 출력:
# ✓ nine-step-workflow v1.0.0
#   프로덕션 수준의 9단계 개발 워크플로우
```

### 방법 2: 수동 설치

```bash
# 1. 플러그인 다운로드
git clone https://github.com/your-org/nine-step-workflow-plugin.git

# 2. 플러그인 디렉토리가 없으면 생성
mkdir -p ~/.claude/plugins

# 3. Claude Code 플러그인 디렉토리에 복사
cp -r nine-step-workflow-plugin ~/.claude/plugins/nine-step-workflow

# 4. 설치 확인
claude plugin list
```

### 방법 3: 개발용 설치 (기여자용)

```bash
# 1. 저장소 복제
git clone https://github.com/your-org/nine-step-workflow-plugin.git
cd nine-step-workflow-plugin

# 2. 개발용 심볼릭 링크 (변경사항이 즉시 반영됨)
ln -s $(pwd) ~/.claude/plugins/nine-step-workflow

# 3. 변경사항 테스트
claude plugin reload nine-step-workflow
```

## ⚙️ 설정

### 1단계: 프로젝트 설정 생성

프로젝트 루트에 `CLAUDE.md` 파일 생성:

```markdown
# MyProject용 Claude Code 가이드라인

## 프로젝트 정보
- **프로젝트 이름**: MyAwesomeApp
- **설명**: 프로젝트 간단한 설명
- **기술 스택**: Python Flask, React, PostgreSQL
- **버전**: 1.0.0

## 기술 스택 세부사항

### 백엔드
- 프레임워크: Flask 2.3.0
- 데이터베이스: PostgreSQL 14
- ORM: SQLAlchemy 2.0
- API 스타일: RESTful JSON

### 프론트엔드
- 프레임워크: React 18
- 상태 관리: Redux Toolkit
- UI 라이브러리: Material-UI 5
- 빌드 도구: Vite

### 테스트
- 백엔드: pytest, pytest-cov
- 프론트엔드: Jest, React Testing Library
- E2E: Playwright

## 코딩 표준

### 일반 규칙
- 최대 함수 길이: 50줄
- 최대 파일 길이: 300줄
- 타입 힌트 사용 (Python) / TypeScript
- 모든 공개 API는 docstring이 있어야 함

### Python 표준
- PEP 8 준수
- 포매팅은 Black 사용
- 린팅은 pylint 사용
- 타입 힌트 필수

### JavaScript/TypeScript 표준
- ESLint Standard 설정 준수
- 포매팅은 Prettier 사용
- 함수형 컴포넌트만 사용 (React)
- 상태 관리는 Hooks 사용

## 개발 워크플로우

### 기능 개발
1. GitHub에서 이슈 생성
2. 기능 설명과 함께 `/workflow-exec` 실행
3. 9단계 워크플로우 따르기
4. 모든 품질 게이트 통과 후 병합

### 버그 수정
1. 버그 재현
2. 실패하는 테스트 생성
3. 버그 설명과 함께 `/workflow-exec` 실행
4. 수정은 새 테스트를 통과해야 함

## 보안 요구사항

### 인증
- 15분 만료 JWT 토큰
- 7일 만료 리프레시 토큰
- 최소 12자 이상 비밀번호

### 입력 검증
- 모든 사용자 입력은 Pydantic으로 검증 (백엔드)
- 모든 사용자 입력은 Zod로 검증 (프론트엔드)
- SQL 파라미터화 필수 (문자열 연결 금지)

### API 보안
- Rate limiting: IP당 100 req/min
- CORS: 특정 origin만 화이트리스트
- 프로덕션에서 HTTPS 필수

## 테스트 요구사항

### 코드 커버리지
- 최소: 전체 80%
- 중요 경로: 100% 커버리지
- 모든 공개 API: 100% 커버리지

### 테스트 전략
- 모든 비즈니스 로직에 대한 단위 테스트
- API 엔드포인트에 대한 통합 테스트
- 중요한 사용자 플로우에 대한 E2E 테스트

## 문서화 표준

### 코드 주석
- 모든 공개 함수/클래스 문서화
- 복잡한 알고리즘 설명
- TODO는 GitHub 이슈로 추적

### API 문서
- OpenAPI/Swagger 사양 유지
- 모든 엔드포인트 문서화
- 요청/응답 예제 제공

## 배포 프로세스

### 환경
- 개발: Local
- 스테이징: staging.myapp.com
- 프로덕션: myapp.com

### 배포 단계
1. 모든 테스트 통과
2. 코드 리뷰 및 승인
3. 스테이징 배포 및 스모크 테스트
4. 프로덕션 배포
5. 30분간 모니터링

## 언어 설정

- **대화 언어**: Korean
- **코드 언어**: English (항상)
- **문서 언어**: Korean
- **주석 언어**: English (항상)
```

### 2단계: 기존 코드에 기능 태그 추가

빠른 발견을 위해 기존 코드에 태그 추가:

```python
# 예제: Python 백엔드 서비스
# @FEAT:user-authentication @COMP:service @TYPE:core @DEPS:database
class AuthService:
    """사용자 인증 및 권한 부여 처리."""

    # @FEAT:user-authentication @COMP:service @TYPE:core
    def authenticate(self, email: str, password: str) -> User:
        """이메일과 비밀번호로 사용자 인증."""
        # 구현...
```

```javascript
// 예제: React 프론트엔드 컴포넌트
// @FEAT:user-profile @COMP:component @TYPE:ui
export function UserProfile({ userId }) {
  // @FEAT:user-profile @COMP:component @TYPE:helper
  const fetchUserData = async (id) => {
    // 구현...
  };
}
```

### 3단계: 기능 카탈로그 생성

`docs/FEATURE_CATALOG.md` 생성:

```markdown
# 기능 카탈로그

## 인증 기능

### user-authentication
- **설명**: 사용자 로그인, 로그아웃, JWT 토큰 관리
- **컴포넌트**: AuthService, LoginForm, AuthMiddleware
- **태그**: @FEAT:user-authentication
- **파일**:
  - backend/services/auth_service.py
  - frontend/components/LoginForm.jsx
  - backend/middleware/auth_middleware.py

### password-reset
- **설명**: 이메일을 통한 비밀번호 재설정
- **컴포넌트**: PasswordResetService, ResetForm
- **태그**: @FEAT:password-reset
- **의존성**: @FEAT:user-authentication, email-service

## 사용자 관리 기능

### user-profile
- **설명**: 사용자 프로필 보기 및 수정
- **컴포넌트**: UserService, ProfilePage, ProfileForm
- **태그**: @FEAT:user-profile
- **파일**:
  - backend/services/user_service.py
  - frontend/pages/ProfilePage.jsx

## 데이터 기능

### data-export
- **설명**: 다양한 형식으로 사용자 데이터 내보내기
- **컴포넌트**: ExportService, ExportButton
- **태그**: @FEAT:data-export
- **의존성**: @FEAT:user-profile

[더 많은 기능 추가...]
```

### 4단계: Git Worktree 디렉토리 설정

`.gitignore`에 추가:

```bash
# Git worktree
.worktree/

# 계획 문서
.plan/

# 임시 테스트 파일
.test/
```

### 5단계: 설치 테스트

```bash
# 프로젝트로 이동
cd ~/my-project

# Claude Code 시작
claude

# 플러그인 테스트
# > /workflow-exec "플러그인 테스트를 위한 간단한 기능 추가"
```

예상되는 동작:
1. `project-planner` 에이전트 활성화
2. 구현 계획 생성
3. `plan-reviewer`가 검증
4. 사용자 승인 요청
5. Git worktree 생성
6. 구현 진행

## 🔧 문제 해결

### 문제: 플러그인을 찾을 수 없음

```bash
# 설치 확인
ls ~/.claude/plugins/nine-step-workflow

# 없으면 재설치
claude plugin install nine-step-workflow
```

### 문제: 에이전트가 활성화되지 않음

**증상**: Claude가 전문화된 에이전트를 사용하지 않음

**해결책**:
1. 플러그인이 활성화되어 있는지 확인: `claude plugin list`
2. plugin.json이 유효한지 확인: `cat ~/.claude/plugins/nine-step-workflow/.claude-plugin/plugin.json`
3. 플러그인 재로드: `claude plugin reload nine-step-workflow`

### 문제: 태그 기반 검색이 작동하지 않음

**증상**: 에이전트가 기존 코드를 찾지 못함

**해결책**:
1. 코드에 기능 태그 추가 (2단계 참조)
2. `docs/FEATURE_CATALOG.md` 생성 (3단계 참조)
3. 태그 확인: `grep -r "@FEAT:" --include="*.py" --include="*.js"`

### 문제: Worktree 생성 실패

**증상**: Git worktree 생성 시 오류

**해결책**:
1. Git 버전 확인: `git --version` (2.25+ 필요)
2. Git 저장소인지 확인: `git status`
3. `.worktree/` 디렉토리 생성: `mkdir .worktree`
4. `.gitignore`에 추가: `echo ".worktree/" >> .gitignore`

### 문제: 스킬이 로드되지 않음

**증상**: 에이전트가 "Skill not found" 메시지 표시

**해결책**:
1. 스킬 디렉토리 존재 확인:
   ```bash
   ls ~/.claude/plugins/nine-step-workflow/skills/
   ```
2. SKILL.md 파일 확인:
   ```bash
   find ~/.claude/plugins/nine-step-workflow/skills -name "SKILL.md"
   ```
3. 파일이 없으면 플러그인 재설치

### 문제: 명령어가 작동하지 않음

**증상**: `/workflow-exec`가 인식되지 않음

**해결책**:
1. 명령어 디렉토리 확인:
   ```bash
   ls ~/.claude/plugins/nine-step-workflow/commands/
   ```
2. 명령어 파일의 frontmatter 확인
3. Claude Code 재로드
4. 시도: `claude plugin reload nine-step-workflow`

## 🎓 다음 단계

설치 후:

1. **빠른 시작 읽기**: [README.md](./README.md#빠른-시작) 참조
2. **예제 시도**: 먼저 간단한 기능으로 테스트
3. **설정 커스터마이징**: 프로젝트에 맞게 `CLAUDE.md` 조정
4. **기능 태그 추가**: 더 나은 발견을 위해 기존 코드에 태그 추가
5. **커뮤니티 참여**: [GitHub Discussions](https://github.com/your-org/nine-step-workflow-plugin/discussions)

## 🔄 업데이트

### CLI를 통한 업데이트

```bash
# 업데이트 확인
claude plugin update nine-step-workflow

# 변경 로그 확인
cat ~/.claude/plugins/nine-step-workflow/CHANGELOG.md
```

### 수동 업데이트

```bash
# 현재 버전 백업
cp -r ~/.claude/plugins/nine-step-workflow ~/.claude/plugins/nine-step-workflow.backup

# 새 버전 다운로드
git clone https://github.com/your-org/nine-step-workflow-plugin.git

# 이전 버전 교체
rm -rf ~/.claude/plugins/nine-step-workflow
cp -r nine-step-workflow-plugin ~/.claude/plugins/nine-step-workflow

# 플러그인 재로드
claude plugin reload nine-step-workflow
```

## 🗑️ 제거

### CLI를 통한 제거

```bash
claude plugin uninstall nine-step-workflow
```

### 수동 제거

```bash
# 플러그인 디렉토리 제거
rm -rf ~/.claude/plugins/nine-step-workflow

# 제거 확인
claude plugin list
```

### 프로젝트 설정 정리 (선택사항)

프로젝트에서 플러그인 흔적을 완전히 제거하려면:

```bash
# 계획 문서 제거
rm -rf .plan/

# Worktree 제거
git worktree list | grep ".worktree" | awk '{print $1}' | xargs -I {} git worktree remove {}

# Worktree 디렉토리 제거
rm -rf .worktree/

# 테스트 디렉토리 제거
rm -rf .test/

# 기능 카탈로그 제거 (필요 없으면)
rm docs/FEATURE_CATALOG.md
```

**참고**: `CLAUDE.md`는 프로젝트별 가이드라인이 있을 수 있으므로 보관하세요.

## 🆘 지원

문제가 발생하면:

1. **문서 확인**: [README.md](./README.md), [CONTRIBUTING.md](./CONTRIBUTING.md)
2. **이슈 검색**: [GitHub Issues](https://github.com/your-org/nine-step-workflow-plugin/issues)
3. **커뮤니티 질문**: [GitHub Discussions](https://github.com/your-org/nine-step-workflow-plugin/discussions)
4. **버그 보고**: 재현 단계와 함께 상세한 이슈 생성

---

**설치 완료! 9단계 워크플로우로 개발할 준비가 되었습니다.** 🚀
