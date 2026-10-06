// CONFIGURAÇÃO SUPABASE
const SUPABASE_URL = 'https://tlubxzkegyknqvwuaelg.supabase.co';
const SUPABASE_KEY = 'sb_publishable_8L8ipeuPm7Bi_Vpd6D8pjQ_ye5IOHml';
const _supabase = supabase.createClient(SUPABASE_URL, SUPABASE_KEY);

// ELEMENTOS DA TELA
const modalAuth = document.getElementById('modal-auth');
const btnModalNav = document.getElementById('btn-modal-nav');
const btnModalHero = document.getElementById('btn-modal-hero');
const btnFecharModal = document.getElementById('btn-fechar-modal');
const formAuth = document.getElementById('form-auth');
const msgText = document.getElementById('msg');

// FUNÇÕES DO MODAL
function abrirModal() { 
    if (modalAuth) modalAuth.classList.remove('hidden'); 
}
function fecharModal() { 
    if (modalAuth) modalAuth.classList.add('hidden'); 
}

// EVENT LISTENERS DE CLIQUE
if (btnModalNav) btnModalNav.addEventListener('click', abrirModal);
if (btnModalHero) btnModalHero.addEventListener('click', abrirModal);
if (btnFecharModal) btnFecharModal.addEventListener('click', fecharModal);

// ENVIO DE DADOS APENAS DE NOME E E-MAIL
if (formAuth) {
    formAuth.addEventListener('submit', async (e) => {
        e.preventDefault();
        
        const nome = document.getElementById('nome').value;
        const email = document.getElementById('email').value;

        if (msgText) {
            msgText.className = 'mt-4 text-center text-sm font-semibold text-slate-400';
            msgText.innerText = 'Enviando pré-registro...';
        }

        try {
            // Insere apenas o nome e e-mail que existem na tabela
            const { error } = await _supabase
                .from('jogadores')
                .insert([{ 
                    nome: nome, 
                    email: email 
                }]);

            if (error) {
                if (msgText) {
                    msgText.className = 'mt-4 text-center text-sm font-semibold text-red-400';
                    msgText.innerText = 'Erro ao cadastrar: ' + error.message;
                }
            } else {
                if (msgText) {
                    msgText.className = 'mt-4 text-center text-sm font-semibold text-emerald-400';
                    msgText.innerText = 'Cadastro realizado com sucesso!';
                }
                formAuth.reset();
                setTimeout(() => { fecharModal(); }, 1500);
            }
        } catch (err) {
            console.error('Erro ao conectar:', err);
            if (msgText) {
                msgText.className = 'mt-4 text-center text-sm font-semibold text-red-400';
                msgText.innerText = 'Erro ao conectar ao banco de dados.';
            }
        }
    });
}