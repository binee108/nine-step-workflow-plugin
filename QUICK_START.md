# 빠른 시작 가이드

5분 안에 Nine-Step Workflow 플러그인을 설치하고 실행하세요.

## 🚀 설치 (1분)

```bash
# 플러그인 설치
claude plugin install nine-step-workflow

# 설치 확인
claude plugin list
# 표시되어야 함: ✓ nine-step-workflow v1.0.0
```

## ⚙️ 최소 설정 (2분)

프로젝트 루트에 `CLAUDE.md` 생성:

```markdown
# Claude Code 가이드라인

## 프로젝트 정보
- 프로젝트 이름: MyApp
- 기술 스택: [당신의 스택, 예: Python Flask, React]
- 코딩 표준: [당신의 표준, 예: PEP 8, ESLint]

## 언어 설정
- 대화 언어: Korean
- 코드 언어: English
```

`.gitignore`에 추가:
```bash
echo ".worktree/" >> .gitignore
echo ".plan/" >> .gitignore
echo ".test/" >> .gitignore
```

## 🎯 첫 번째 기능 (2분)

Claude Code를 시작하고 시도해보세요:

```
사용자: 내 앱 설정에 다크 모드 토글을 추가해야 해. 도와줄 수 있어?

예상되는 흐름:
1. project-planner가 요구사항 분석
2. 3단계 구현 계획 생성
3. plan-reviewer가 접근법 검증
4. 사용자 승인 요청
5. Git worktree 생성
6. 각 단계 구현 (3-9단계)
7. 병합 및 정리
```

또는 명시적 명령어 사용:

```
/workflow-exec "설정에 다크 모드 토글 추가"
```

## ✅ 성공 지표

다음과 같은 경우 제대로 작동하고 있는 것입니다:

1. **계획**: 상세한 단계별 분해를 볼 수 있음
   ```
   1단계: 테마 상태 관리 (2시간)
   2단계: UI 토글 컴포넌트 (1.5시간)
   3단계: 기존 컴포넌트에 적용 (2시간)
   ```

2. **승인**: 플러그인이 코딩 전에 승인 요청
   ```
   🤔 이 계획을 승인하시겠습니까? (2.5단계)
   ```

3. **Worktree**: Git worktree가 자동으로 생성됨
   ```
   .worktree/dark-mode-toggle/ 생성됨
   ```

4. **품질 게이트**: 여러 리뷰 단계
   ```
   ✅ 코드 리뷰 완료 - 승인됨
   ✅ 문서 리뷰 완료 - 승인됨
   ✅ 테스트 리뷰 완료 - 승인됨
   ```

5. **정리**: 병합 후 자동 정리
   ```
   ✅ 계획 삭제됨
   ✅ Worktree 제거됨
   ✅ 브랜치 정리됨
   ```

## 🎓 다음 단계

- **전체 문서 읽기**: [README.md](./README.md)
- **프로젝트 구성**: [INSTALLATION.md](./INSTALLATION.md)
- **워크플로우 학습**: [Skills: nine-step-workflow](./skills/nine-step-workflow/SKILL.md)
- **태그 추가**: 빠른 발견을 위해 코드에 `@FEAT:` 태그 달기
- **카탈로그 생성**: 기능 목록을 위한 `docs/FEATURE_CATALOG.md` 작성

## 💡 빠른 팁

1. **태그 사용**: 30초 만에 발견하려면 코드에 `# @FEAT:feature-name` 추가
2. **품질 게이트 신뢰**: 리뷰 단계를 건너뛰지 마세요
3. **단계로 나누기**: 대규모 기능은 여러 1-3시간 단계로 나누는 것이 더 잘 작동함
4. **계획 승인**: 구현 전에 항상 2.5단계에서 계획 검토
5. **자동 정리 허용**: 플러그인이 병합 후 자동 정리 (worktree를 수동으로 삭제하지 마세요)

## 🆘 일반적인 문제

**플러그인을 찾을 수 없나요?**
```bash
ls ~/.claude/plugins/nine-step-workflow
# 없으면: claude plugin install nine-step-workflow
```

**에이전트가 활성화되지 않나요?**
```bash
claude plugin reload nine-step-workflow
```

**Worktree 오류?**
```bash
git --version  # 2.25+ 필요
mkdir .worktree
```

## 📚 리소스

- [전체 README](./README.md) - 완전한 문서
- [설치 가이드](./INSTALLATION.md) - 상세 설정
- [기여하기](./CONTRIBUTING.md) - 개발 참여
- [변경 로그](./CHANGELOG.md) - 버전 히스토리

---

**준비되었습니다! 9단계 워크플로우로 개발을 시작하세요.** 🎉
