# Quick Start - Carregamento de Dados

## 🚀 Início Rápido (3 comandos)

```bash
cd /scripts/data_collection
bash 00_verify_environment.sh
bash RUN_ALL_DIMENSIONS.sh
```

**Pronto!** O script vai executar tudo automaticamente.

---

## ⏱️ Tempo Estimado

- **Verificação:** 30 segundos
- **Carregamento completo:** 60-90 minutos
- **Total:** ~1h30min

---

## 📊 O que Será Carregado

| Dimensão | Registros | Tempo |
|----------|-----------|-------|
| Territórios | 140 | ~5 min |
| Econômica | 700 | ~25 min |
| Social | 700 | ~20 min |
| Territorial | 700 | ~20 min |
| Ambiental | 700 | ~25 min |
| **TOTAL** | **2.800** | **~90 min** |

---

## ✅ Checklist Pré-Execução

- [ ] Está no Replit do projeto
- [ ] PostgreSQL está ativo
- [ ] `DATABASE_URL` está definida
- [ ] Python 3 disponível
- [ ] Tem ~1h30min disponível

---

## 🎯 Após a Execução

Você terá:
- ✅ 140 territórios com coordenadas
- ✅ 2.800 indicadores reais (4 dimensões × 140 territórios × 5 anos)
- ✅ Backup completo do banco
- ✅ Logs detalhados
- ✅ Relatório de verificação

---

## 📚 Documentação Completa

- **Script Automatizado:** `README_RUN_ALL.md`
- **Guia Manual:** `/docs/GUIA_EXECUCAO_MANUAL_DIMENSOES.md`
- **Prompts Replit AI:** `/docs/prompts/README.md`

---

## 🆘 Problemas?

```bash
# Verificar ambiente
bash 00_verify_environment.sh

# Ver logs
cat logs/run_all_*.log

# Restaurar backup
psql $DATABASE_URL < backup_before_load_*.sql
```

---

**É isso! Simples e direto.** 🎉
