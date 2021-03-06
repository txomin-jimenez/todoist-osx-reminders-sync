JsOsaDAS1.001.00bplist00�Vscripto� / /   O S X   r e m i n d e r s   a p p   h a n d l e r 
 v a r   r e m i n d e r s A p p   =   A p p l i c a t i o n ( " R e m i n d e r s " ) ; 
 r e m i n d e r s A p p . i n c l u d e S t a n d a r d A d d i t i o n s   =   t r u e ; 
 
 / /   t h i s   o b j e c t   w i l l   s u p p o r t   t a s k   d a t a   f o r   t w o   a p p s 
 v a r   m a c R e m i n d e r s D a t a   =   { } 
 v a r   t o d o i s t D a t a   =   { } ; 	 
 
 v a r   g e t T o d o i s t T o k e n   =   f u n c t i o n ( ) { 
 	 v a r   a p p   =   A p p l i c a t i o n . c u r r e n t A p p l i c a t i o n ( ) ; 
 	 a p p . i n c l u d e S t a n d a r d A d d i t i o n s = t r u e ; 
 
 	 r e t u r n   a p p . d o S h e l l S c r i p t ( ' c a t   ~ / A p p l i c a t i o n s / t o d o i s t _ o s x _ s y n c / t o k e n ' ) 
 } 
 
 / /   l o a d   T o d o i s t   d a t a   f r o m   r e m o t e   A P I 
 v a r   g e t T o d o i s t D a t a   =   f u n c t i o n ( ) { 
 	 v a r   t o k e n   =   g e t T o d o i s t T o k e n ( ) 
 	 v a r   a p p   =   A p p l i c a t i o n . c u r r e n t A p p l i c a t i o n ( ) ; 
 	 a p p . i n c l u d e S t a n d a r d A d d i t i o n s = t r u e ; 
 	 t o d o i s t D a t a   =   J S O N . p a r s e ( a p p . d o S h e l l S c r i p t ( ' c u r l   " h t t p s : / / t o d o i s t . c o m / A P I / v 6 / s y n c ? t o k e n = '   +   t o k e n   +   ' & s e q _ n o = 0 & r e s o u r c e _ t y p e s = \ \ [ \ \ " p r o j e c t s \ \ " , \ \ " i t e m s \ \ " , \ \ " l a b e l s \ \ " \ \ ] " ' ) ) ; 
 	 
 
 } 
 
 / /   W I P 
 v a r   s a v e S y n c D a t a   =   f u n c t i o n ( ) { 
 	 v a r   a p p   =   A p p l i c a t i o n . c u r r e n t A p p l i c a t i o n ( ) ; 
 	 a p p . i n c l u d e S t a n d a r d A d d i t i o n s = t r u e ; 
 
 	 a p p . d o S h e l l S c r i p t ( ' e c h o   " ' +   J S O N . s t r i n g i f y ( m a c R e m i n d e r s D a t a ) . r e p l a c e ( ' & ' , ' \ \ & ' )   + ' "   >   ~ / A p p l i c a t i o n s / t o d o i s t _ o s x _ s y n c / s y n c . d a t ' ) 
 } 
 
 / /   l o a d   O S X   R e m i n d e r s 
 v a r   g e t M a c R e m i n d e r s D a t a   =   f u n c t i o n ( ) { 
 	 m a c R e m i n d e r s D a t a . P r o j e c t s B y I d   =   { } 
 	 m a c R e m i n d e r s D a t a . P r o j e c t s B y N a m e   =   { } 
 	 m a c R e m i n d e r s D a t a . t a s k B y P r o j e c t A n d N a m e   =   { } 
 	 
 	 f o r   ( i = 0 ; i < r e m i n d e r s A p p . l i s t s . l e n g t h ; i + + ) { 
 	 	 v a r   l i s t   =   r e m i n d e r s A p p . l i s t s [ i ] ; 	 
 	 	 m a c R e m i n d e r s D a t a . P r o j e c t s B y I d [ l i s t . i d ( ) ]   =   l i s t 
 	 	 m a c R e m i n d e r s D a t a . P r o j e c t s B y N a m e [ l i s t . n a m e ( ) ]   =   l i s t 
 
 	 	 m a c R e m i n d e r s D a t a . t a s k B y P r o j e c t A n d N a m e [ l i s t . n a m e ( ) ]   =   { } 
 	 	 f o r   ( j = 0 ; j < l i s t . r e m i n d e r s . l e n g t h ; j + + ) { 
 	 	 	 v a r   r e m i n d e r   =   l i s t . r e m i n d e r s [ j ] ; 
 	 	 	 m a c R e m i n d e r s D a t a . t a s k B y P r o j e c t A n d N a m e [ l i s t . n a m e ( ) ] [ r e m i n d e r . n a m e ( ) ] =   r e m i n d e r 
 	 	 } ; 
 	 } 	 
 } 
 
 / /   l o a d   O S X   R e m i n d e r s   L i s t 
 v a r   g e t M a c P r o j e c t s   =   f u n c t i o n ( ) { 
 	 v a r   m a c P r o j e c t s   =   { } 
 	 f o r   ( i = 0 ; i < r e m i n d e r s A p p . l i s t s . l e n g t h ; i + + ) { 
 	 	 m a c P r o j e c t s [ r e m i n d e r s A p p . l i s t s [ i ] . n a m e ( ) ]   =   r e m i n d e r s A p p . l i s t s [ i ] 
 	 } 
 	 r e t u r n   m a c P r o j e c t s ; 
 } 
 
 / /   l o a d   O S X   R e m i n d e r s 
 v a r   g e t M a c R e m i n d e r s   =   f u n c t i o n ( ) { 
 
 	 f o r   ( i = 0 ; i < r e m i n d e r s A p p . l i s t s . l e n g t h ; i + + ) { 
 	 	 v a r   l i s t   =   r e m i n d e r s A p p . l i s t s [ i ] ; 
 	 	 m a c R e m i n d e r s [ l i s t . i d ( ) ]   =   { 
 	 	 	 n a m e :   l i s t . n a m e ( ) , 
 	 	 	 t a s k s :   { } 
 	 	 } ; 
 	 	 f o r   ( j = 0 ; j < l i s t . r e m i n d e r s . l e n g t h ; j + + ) { 
 	 	 	 v a r   r e m i n d e r   =   l i s t . r e m i n d e r s [ j ] ; 
 	 	 	 m a c R e m i n d e r s [ l i s t . i d ( ) ] . t a s k s [ r e m i n d e r . i d ( ) ]   =   { 
 	 	 	 	 n a m e :   r e m i n d e r . n a m e ( ) , 
 	 	 	 	 c o m p l e t e d :   r e m i n d e r . c o m p l e t e d ( ) 
 	 	 	 } 
 	 	 } ; 
 	 } 
 } 
 
 / /   c r e a t e   a   O S X   T a s k   L i s t   g i v e n   i n p u t   d a t a 
 v a r   c r e a t e M a c P r o j e c t   =   f u n c t i o n ( n a m e ) { 
 	 
 	 v a r   n e w P r o j e c t   =   r e m i n d e r s A p p . m a k e ( { 
 	 	 n e w :   " l i s t " , 
 	 	 w i t h P r o p e r t i e s :   { 
 	 	 	 n a m e :   n a m e 
 	 	 } 	 
 	 } ) ; 
 	 
 	 m a c R e m i n d e r s D a t a . P r o j e c t s B y I d [ n e w P r o j e c t . i d ( ) ]   =   n e w P r o j e c t 
 	 m a c R e m i n d e r s D a t a . P r o j e c t s B y N a m e [ n e w P r o j e c t . n a m e ( ) ]   =   n e w P r o j e c t 
 
 	 m a c R e m i n d e r s D a t a . t a s k B y P r o j e c t A n d N a m e [ n e w P r o j e c t . n a m e ( ) ]   =   { } 	 
 	 
 } 
 
 / /   c r e a t e   a   O S X   R e m i n d e r   g i v e n   i n p u t   d a t a 
 v a r   c r e a t e M a c R e m i n d e r   =   f u n c t i o n ( t a s k L i s t ,   n a m e ,   b o d y ,   d u e D a t e ,   p r i o r i t y ,   r e m i n d M e D a t e ) { 
 
 	 v a r   p r o p s   =   { 
 	 	 n a m e :   n a m e 
 	 } 	 
 	 
 	 i f   ( b o d y   ! =   n u l l   | |   b o d y   ! =   u n d e f i n e d ) 
 	 	 p r o p s . b o d y   =   b o d y 
 
 	 i f   ( d u e D a t e   ! =   n u l l   | |   d u e D a t e   ! =   u n d e f i n e d ) 
 	 	 p r o p s . d u e D a t e   =   d u e D a t e 	 	 
 
 	 i f   ( p r i o r i t y   ! =   n u l l   | |   p r i o r i t y   ! =   u n d e f i n e d ) 
 	 	 p r o p s . p r i o r i t y   =   p r i o r i t y 
 	 	 
 	 i f   ( r e m i n d M e D a t e   ! =   n u l l   | |   r e m i n d M e D a t e   ! =   u n d e f i n e d ) 
 	 	 p r o p s . r e m i n d M e D a t e   =   r e m i n d M e D a t e 
 	 	 
 	 c o n s o l e . l o g ( p r o p s ) 	 
 	 	 
 	 v a r   n e w R e m i n d e r   =   t a s k L i s t . m a k e ( { 
 	 	 n e w :   " r e m i n d e r " , 
 	 	 a t :   t a s k L i s t , 
 	 	 w i t h P r o p e r t i e s :   p r o p s 	 
 	 } ) ; 
 	 
 	 r e t u r n   n e w R e m i n d e r 
 	 
 } 
 
 / /   c o n v e r t   T o d o i s t   t a s k   l a b e l   i d   a r r a y   t o   l a b e l   n a m e   s t r i n g 
 v a r   t a s k L a b e l s T o S t r i n g   =   f u n c t i o n ( l a b e l s ) { 
 	 / / c o n s o l e . l o g ( J S O N . s t r i n g i f y ( t o d o i s t D a t a . L a b e l s ) ) 
 	 l a b e l s T x t = u n d e f i n e d 
 	 l a b e l s . f o r E a c h ( f u n c t i o n ( l a b e l I d , i n d e x ) { 
 	 	 l a b e l O b j   =   t o d o i s t D a t a . L a b e l s . f i n d ( f u n c t i o n ( l a b e l O b j _ ) { 
 	 	 	 r e t u r n   l a b e l O b j _ . i d   = =   l a b e l I d 
 	 	 } ) 
 	 	 i f   ( l a b e l O b j   ! =   n u l l   & &   l a b e l O b j   ! =   u n d e f i n e d ) 
 	 	 	 i f   ( l a b e l s T x t   = =   u n d e f i n e d ) 
 	 	 	 	 l a b e l s T x t   =   ' @ ' + l a b e l O b j . n a m e 
 	 	 	 e l s e 
 	 	 	 	 l a b e l s T x t   =   l a b e l s T x t   +   "   @ "   +   l a b e l O b j . n a m e 
 	 	 	 
 	 } ) 
 	 r e t u r n   l a b e l s T x t 
 } 
 
 / /   l o o p   T o d o i s t   t a s k   a n d   c r e a t e   t h e m   i n   O S X   R e m i n d e r s 
 v a r   s y n c P r o j e c t T a s k s   =   f u n c t i o n ( p r o j e c t N a m e ) { 
 	 	 
 	 t o d o i s t T a s k s   =   t o d o i s t D a t a . I t e m s . f i l t e r ( f u n c t i o n ( t a s k ) { 
 	 	 r e t u r n   t a s k . p r o j e c t _ i d   = =   t o d o i s t D a t a . P r o j e c t s B y N a m e [ p r o j e c t N a m e ] . i d 
 	 } ) . s o r t ( f u n c t i o n ( t a s k 1 , t a s k 2 ) { 
 	 	 r e t u r n ( t a s k 1 . i t e m _ o r d e r   -   t a s k 2 . i t e m _ o r d e r ) 
 	 } ) 
 	 
 	 t o d o i s t T a s k s . f o r E a c h ( f u n c t i o n ( t a s k , i n d e x ) { 
 	 	 v a r   i s C o m p l e t e d   =   t a s k . c h e c k e d   | |   t a s k . i n _ h i s t o r y 
 	 	 
 	 	 i f   ( t a s k . i n d e n t   >   0 ) 
 	 	 	 t a s k . c o n t e n t   =   A r r a y ( t a s k . i n d e n t ) . j o i n ( "%�   " )   +   t a s k . c o n t e n t 
 	 	 	 
 	 	 i f   ( ! i s C o m p l e t e d ) { 	 
 	 	 	 m a c T a s k   =   m a c R e m i n d e r s D a t a . t a s k B y P r o j e c t A n d N a m e [ p r o j e c t N a m e ] [ t a s k . c o n t e n t ] 
 	 	 	 i f ( ! m a c T a s k ) { 
 	 	 	 	 / /   t a s k   d a t e   c o u l d   b e   n u l l 
 	 	 	 	 i f   ( t a s k . d u e _ d a t e _ u t c   ! =   n u l l   & &   t a s k . d u e _ d a t e _ u t c   ! =   u n d e f i n e d ) 
 	 	 	 	 	 t a s k D a t e   =   n e w   D a t e ( t a s k . d u e _ d a t e _ u t c ) 
 	 	 	 	 e l s e 
 	 	 	 	 	 t a s k D a t e   =   u n d e f i n e d 
 	 	 	 	 n e w M a c R e m i n d e r   =   c r e a t e M a c R e m i n d e r ( m a c R e m i n d e r s D a t a . P r o j e c t s B y N a m e [ p r o j e c t N a m e ] ,   t a s k . c o n t e n t ,   t a s k L a b e l s T o S t r i n g ( t a s k . l a b e l s ) ,   t a s k D a t e   ) 
 	 	 	 } 
 	 
 	 	 } 
 	 } ) 
 } 
 
 / /   L o o p   T o d o i s t   p r o j e c t s   a n d   c r e a t e   t h e m   a s   O S X   R e m i n d e r s   L i s t 
 v a r   s y n c P r o j e c t s   =   f u n c t i o n ( ) { 
 	 t o d o i s t P r o j e c t s   =   t o d o i s t D a t a . P r o j e c t s ; 
 	 m a c P r o j e c t s   =   m a c R e m i n d e r s D a t a . P r o j e c t s B y N a m e ; 
 	 
 	 t o d o i s t P r o j e c t s . s o r t ( f u n c t i o n ( p r o 1 ,   p r o 2 ) { 
 	 	 r e t u r n ( p r o 1 . i t e m _ o r d e r   -   p r o 2 . i t e m _ o r d e r ) 	 	 	 
 	 } ) 
 	 t o d o i s t D a t a . P r o j e c t s B y I d   =   { } 
 	 t o d o i s t D a t a . P r o j e c t s B y N a m e   =   { } 	 
 	 
 	 t o d o i s t P r o j e c t s . f o r E a c h ( f u n c t i o n ( p r o j e c t , i n d e x ) { 
 	 	 t o d o i s t D a t a . P r o j e c t s B y I d [ p r o j e c t . i d ]   =   p r o j e c t 
 	 	 i f   ( p r o j e c t . i n d e n t   >   0 ) 
 	 	 	 p r o j e c t . n a m e   =   A r r a y ( p r o j e c t . i n d e n t ) . j o i n ( "%�   " )   +   p r o j e c t . n a m e 
 	 	 t o d o i s t D a t a . P r o j e c t s B y N a m e [ p r o j e c t . n a m e ]   =   p r o j e c t 	 
 	 	 	 
 	 	 i f   ( p r o j e c t . i s _ d e l e t e d   = =   0   & &   O b j e c t . k e y s ( m a c P r o j e c t s ) . i n d e x O f ( p r o j e c t . n a m e )   = =   - 1 ) { 
 	 	 	 c r e a t e M a c P r o j e c t ( p r o j e c t . n a m e ) 
 	 	 } 
 	 	 
 	 	 s y n c P r o j e c t T a s k s ( p r o j e c t . n a m e ) 
 	 } ) 	 
 
 } 
 
 
 / /   m a i n   e n t r y   p o i n t 
 
 g e t T o d o i s t D a t a ( ) 
 g e t M a c R e m i n d e r s D a t a ( ) 
 s y n c P r o j e c t s ( ) 
 / / s a v e S y n c D a t a ( ) 
 
 
                              +�jscr  ��ޭ