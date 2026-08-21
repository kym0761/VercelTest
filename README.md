# BlazorDemo

.NET 10 + Blazor WebAssembly(독립 실행형)로 만든 정적 웹 앱입니다. 서버 없이 브라우저에서 실행되며, Home / Counter / Weather / Calculator 페이지를 포함합니다.

## 로컬 실행

```bash
dotnet run
```

기본적으로 `http://localhost:5159`에서 열립니다.

## 정적 파일로 빌드

```bash
dotnet publish -c Release -o publish
```

결과물은 `publish/wwwroot`에 생성되며, 이 폴더 자체가 그대로 정적 호스팅에 올릴 수 있는 완성된 사이트입니다.

## GitHub + Vercel 배포

### 1. GitHub 저장소 생성 및 푸시

```bash
git add -A
git commit -m "Initial commit"
gh repo create <repo-name> --source=. --public --push
```

`gh` CLI가 없다면 GitHub에서 새 저장소를 만든 뒤 다음으로 연결하세요.

```bash
git remote add origin https://github.com/<username>/<repo-name>.git
git branch -M main
git push -u origin main
```

### 2. Vercel 연동

1. [vercel.com](https://vercel.com)에서 New Project → 방금 만든 GitHub 저장소 선택
2. Framework Preset은 **Other**로 둡니다 (`vercel.json`이 빌드 설정을 담당)
3. 별도 설정 없이 Deploy를 누르면 저장소에 포함된 [`vercel.json`](vercel.json)과 [`vercel-build.sh`](vercel-build.sh)이 자동으로:
   - 빌드 컨테이너에 .NET 10 SDK를 설치하고
   - `dotnet publish -c Release -o publish`를 실행하고
   - `publish/wwwroot`를 정적 사이트로 배포합니다
4. 이후 `main` 브랜치에 푸시할 때마다 Vercel이 자동으로 재배포합니다.

### 왜 WebAssembly인가

Vercel은 서버리스/정적 호스팅 구조라 Blazor **Server**가 필요로 하는 상시 SignalR 연결을 지원하지 않습니다. 그래서 이 프로젝트는 브라우저에서 전부 실행되는 Blazor **WebAssembly**로 구성되어 있으며, 빌드 결과물이 순수 정적 파일(HTML/CSS/JS/WASM)이라 Vercel과 완벽히 호환됩니다.

## 프로젝트 구조

- `Pages/` — 라우팅되는 페이지 컴포넌트 (Home, Counter, Weather, Calculator)
- `Layout/` — 공통 레이아웃과 네비게이션
- `wwwroot/` — 정적 자산 및 `index.html` 호스트 페이지
- `vercel.json` / `vercel-build.sh` — Vercel 배포용 빌드 설정
