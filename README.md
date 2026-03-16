# Interactive Map App

## Local Run

```bash
npm install
npm run dev -- --host 127.0.0.1 --port 5174
```

Open: `http://127.0.0.1:5174`

## Cloud Save Between Browsers (Firebase)

To let a teacher see maps from another browser/device, enable Firebase cloud mode.

### 1. Create Firebase resources

1. Open Firebase Console and create/select a project.
2. Add a **Web App** and copy its Firebase config object.
3. In **Authentication** -> **Sign-in method**, enable **Anonymous**.
4. In **Firestore Database**, create a database (production or test mode).

### 2. Configure this project

Edit `public/firebase-config.js`:

```js
window.APP_ID = "interactive-map";
window.FIREBASE_CONFIG = {
  apiKey: "...",
  authDomain: "...",
  projectId: "...",
  storageBucket: "...",
  messagingSenderId: "...",
  appId: "..."
};
```

If `window.FIREBASE_CONFIG` stays `null`, the app works in local-only mode (`localStorage`).

### 3. Firestore security rules (minimum working setup)

```text
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /artifacts/{appId}/teachers/{teacherId}/projects/{projectId} {
      allow read, write: if request.auth != null;
    }
  }
}
```

### 4. Data path used by the app

`artifacts/{appId}/teachers/{teacherId}/projects/{projectId}`

`teacherId` is selected in the app UI (the "מזהה מורה" flow).

## Build

```bash
npm run build
```
