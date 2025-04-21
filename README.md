## 🛠️ Tech Stack

### ⚙️ Backend
| Tool | Purpose |
|------|---------|
| **Ruby on Rails 8.0.1** | Main web framework |
| **PostgreSQL** | Relational database (see `config/database.yml`) |
| **Devise** | User authentication & session management |
| **RankedModel** | Maintains ordered lists (e.g., tasks) |
| **Sidekiq** | Background job processing for task reminders |
| **Action Mailer** | Sending email notifications |

### 🎨 Front‑end
| Tool | Purpose |
|------|---------|
| **Hotwire / Turbo** | Real‑time page updates without full reloads |
| **Stimulus** | Lightweight JavaScript controller framework |
| **SortableJS** | Drag‑and‑drop (see `sortable_controller.js`)

### 🚀 Deployment
| Tool | Purpose |
|------|---------|
| **Docker / Dockerfile** | Containerization for local & prod parity |
| **Kamal** | Not working yet |
| **Render** | Cloud hosting (see `render.yaml`) |
