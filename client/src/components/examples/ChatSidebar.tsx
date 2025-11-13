import ChatSidebar from '../layout/ChatSidebar';

export default function ChatSidebarExample() {
  return (
    <div className="flex h-screen bg-background">
      <div className="flex-1 p-8">
        <h2 className="text-2xl font-semibold mb-4">Conteúdo Principal</h2>
        <p className="text-muted-foreground">O chat IA aparece fixo na lateral direita.</p>
      </div>
      <ChatSidebar context="Dimensão Econômica" />
    </div>
  );
}
