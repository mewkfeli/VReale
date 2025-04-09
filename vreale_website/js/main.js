document.addEventListener('DOMContentLoaded', function() {
    // Ограничиваем показ комментариев (первые 3) и добавляем кнопку если нужно
    document.querySelectorAll('.thread-comments').forEach(function(commentsContainer) {
        const allComments = commentsContainer.querySelectorAll('.comment');
        const replyCount = parseInt(commentsContainer.nextElementSibling.querySelector('.thread-replies').textContent.match(/\d+/)[0]);
        
        if (allComments.length > 3 || replyCount > 3) {
            // Скрываем все комментарии кроме первых 3
            allComments.forEach(function(comment, index) {
                if (index >= 3) {
                    comment.style.display = 'none';
                }
            });
            
            // Обновляем текст кнопки с реальным количеством ответов
            const viewThreadBtn = commentsContainer.querySelector('.view-thread-button');
            if (viewThreadBtn) {
                viewThreadBtn.textContent = `Перейти в тред (${replyCount} ответов)`;
                viewThreadBtn.style.display = 'inline-block';
            }
        } else {
            // Скрываем кнопку если комментариев <= 3
            const viewThread = commentsContainer.querySelector('.view-thread');
            if (viewThread) {
                viewThread.style.display = 'none';
            }
        }
    });
});