package;

#if flixel
import flixel.FlxBasic;
import flixel.FlxG;
#end

/**
 * Classe utilitária para `Array`, ideal para uso com `using`.
 * **Autor:** dre
 */
@:final
class ArrayTools {
    /**
     * Construtor privado impede `new ArrayTools()`.
     */
    @:noCompletion
    private function new():Void {}

    /**
     * Retorna o primeiro item de uma `Array`.
     * 
     * ---
     * **Exemplo de uso:**
     * ```haxe
     * var minhaArray:Array<String> = ['Primeiro', 'Último'];
     * trace(minhaArray.firstItem()); // Resultado: Primeiro.
     * ```
     * ---
     * 
     * @return O primeiro item da lista (ou `null`, caso a lista não tenha itens).
     * @since 0.0.1
     */
    public inline static function firstItem<T>(array:Array<T>):Null<T>
        return hasItems(array) ? array[0] : null;

    /**
     * Retorna o último item de uma `Array`.
     * 
     * ---
     * **Exemplo de uso:**
     * ```haxe
     * var minhaArray:Array<String> = ['Primeiro', 'Último'];
     * trace(minhaArray.lastItem()); // Resultado: Último.
     * ```
     * ---
     * 
     * @return O último item da lista (ou `null`, caso a lista não tenha itens).
     * @since 0.0.1
     */
    public inline static function lastItem<T>(array:Array<T>):Null<T>
        return hasItems(array) ? array[array.length - 1] : null;

    /**
     * Indica se a `Array` contém itens.
     * 
     * ---
     * **Exemplo de uso:**
     * ```haxe
     * var minhaArray:Array<String> = [];
     * trace(minhaArray.hasItems()); // Resultado: false.
     * ```
     * ---
     * 
     * @return `true` se a lista contém algum item; caso contrário, `false`.
     * @since 0.0.1
     */
    public inline static function hasItems<T>(array:Array<T>):Bool
        return array.length > 0;

    /**
     * Embaralha os itens de uma `Array` aleatoriamente.
     * @since 0.0.1
     */
    public inline static function shuffle<T>(array:Array<T>):Array<T> {
        var i:Int = array.length;

        while (i > 1) {
            i--;
            var j:Int = Std.random(i + 1);

            var temp = array[i];
            array[i] = array[j];
            array[j] = temp;
        }

        return array;
    }

    /**
     * Retorna um item aleatório de uma `Array`.
     * @return Um item aleatório da lista (ou `null`, caso a lista não tenha itens).
     * @since 0.0.1
     */
    public inline static function randomItem<T>(array:Array<T>):Null<T> {
        if (hasItems(array)) {
            #if flixel
            return FlxG.random.getObject(array);
            #else
            return array[Std.random(array.length)];
            #end
        }
        return null;
    }

    /**
     * Soma todos os itens de uma `Array` numérica.
     * Caso a `Array` seja de outro tipo, a quantidade de itens é o resultado.
     * 
     * ---
     * **Exemplos de uso:**
     * ```haxe
     * var minhaArrayFloat:Array<Float> = [1.27, 3.18, 2.72];
     * var minhaArrayInt:Array<Int> = [2, 9, 6];
     * var minhaArrayString:Array<String> = ['Um', 'Dois', 'Três'];
     * trace(minhaArrayFloat.sum()); // Resultado: 7.17.
     * trace(minhaArrayInt.sum()); // Resultado: 17.
     * trace(minhaArrayString.sum()); // Resultado: 3.
     * ```
     * ---
     * 
     * @return A soma de todos os itens da lista (ou `null` se a lista não tiver itens).
     * @since 0.0.1
     */
    public inline static function sum<T>(array:Array<T>):Null<T> {
        if (hasItems(array)) {
            var bool:Bool = isArrayOf(array, Int) || isArrayOf(array, Float);
            var total:Dynamic = (bool) ? 0 : array.length;
            if (bool) {
                for (i in 0...array.length)
                    total += array[i];
            }
            return total;
        }
        return null;
    }

    /**
     * Subtrai todos os itens de uma `Array` numérica.
     * Caso a `Array` não seja desse tipo, retorna o negativo da quantidade de itens.
     * 
     * ---
     * **Exemplos de uso:**
     * ```haxe
     * var minhaArrayFloat:Array<Float> = [1.27, 3.18, 2.72];
     * var minhaArrayInt:Array<Int> = [2, 9, 6];
     * var minhaArrayString:Array<String> = ['Um', 'Dois', 'Três'];
     * trace(minhaArrayFloat.sub()); // Resultado: -4.63.
     * trace(minhaArrayInt.sub()); // Resultado: -13.
     * trace(minhaArrayString.sub()); // Resultado: -3.
     * ```
     * ---
     * 
     * @return O resultado da subtração dos itens (ou `null` se a lista não tiver itens).
     * @since 0.0.1
     */
    public inline static function sub<T>(array:Array<T>):Null<T> {
        if (hasItems(array)) {
            var bool = isArrayOf(array, Int) || isArrayOf(array, Float);
            var total:Dynamic = (bool) ? array[0] : 0;
            if (bool) {
                for (i in 0...array.length + 1) // Pula o primeiro item porque a subtração começa a partir dele.
                    total -= (i < array.length) ? (cast array[i]:Dynamic) : 0;
            } else {
                for (i in 0...array.length)
                    total--;
            }
            return total;
        }
        return null;
    }

    /**
     * Retorna um item com base no item atual.
     * 
     * ---
     * **Exemplo de uso:**
     * ```haxe
     * var minhaArray:Array<String> = ['Primeiro', 'Segundo'];
     * trace(minhaArray.nextItem(0)); // Resultado: Segundo.
     * trace(minhaArray.nextItem(2, true)); // Resultado: Primeiro.
     * ```
     * ---
     * 
     * @param curItem O índice do item atual.
     * @param wrap Se `true`, retorna o primeiro item ao ultrapassar os limites da lista.
     * @return O próximo item da lista (ou `null` se a lista não
     * tiver itens ou o índice estiver fora dos limites e `wrap` estiver desativado).
     * @since 0.0.1
     */
    public inline static function nextItem<T>(array:Array<T>, curItem:Int = 0, wrap:Bool = false):Null<T> {
        if (hasItems(array)) {
            if (curItem > (array.length - 1) || curItem < (array.length - 1)) {
                if (wrap)
                    return array[0];
            } else return array[curItem + 1];
        } 
        return null;
    }

    /**
     * Retorna um item com base no item atual.
     * 
     * ---
     * **Exemplo de uso:**
     * ```haxe
     * var minhaArray:Array<String> = ['Primeiro', 'Segundo'];
     * trace(minhaArray.previousItem(1)); // Resultado: Primeiro.
     * trace(minhaArray.previousItem(0, true)); // Resultado: Segundo.
     * ```
     * ---
     * 
     * @param curItem O índice do item atual.
     * @param wrap Se `true`, retorna o último item ao ultrapassar os limites da lista.
     * @return O item anterior da lista (ou `null` se a lista não
     * tiver itens ou o índice estiver fora dos limites e `wrap` estiver desativado).
     * @since 0.0.1
     */
    public inline static function previousItem<T>(array:Array<T>, curItem:Int = 0, wrap:Bool = false):Null<T> {
        if (hasItems(array)) {
            var lengthIndex:Int = array.length - 1;
            if (curItem < lengthIndex || curItem > lengthIndex) {
                if (wrap)
                    return array[lengthIndex];
            } else return array[curItem - 1];
        } 
        return null;
    }

    /**
     * Retorna se uma `Array` é de um tipo específico.
     * 
     * ---
     * **Exemplo de uso:**
     * ```haxe
     * var minhaArray = ['Sim', 'Não'];
     * trace(minhaArray.isArrayOf(String)); // Resultado: true
     * ```
     * ---
     * 
     * @param type O tipo alvo da `Array`.
     * @return `true` se todos os itens forem desse tipo, `false` se algum não for
     * e `null` se a lista não tiver itens.
     * @since 0.0.1
     */
    public static function isArrayOf<T>(array:Array<T>, type:Dynamic):Null<Bool> {
        if (!hasItems(array)) return null;

        for (i in array) {
            if (!Std.isOfType(i, type))
                return false;
        }
        return true;
    }

    /**
     * Destrói os itens que são instâncias de `FlxBasic` e esvazia a `Array`.
     *
     * Se a lista já estiver vazia, retorna uma nova `Array` vazia.
     *
     * @return A lista esvaziada ou uma nova `Array` vazia, caso a lista original já estivesse vazia.
     * @since 0.0.1
     */
    public inline static function clear<T>(array:Array<T>):Array<T> {
        if (hasItems(array)) {
            #if flixel
            for (i in array) {
                if (Std.isOfType(i, FlxBasic)) {
                    var b = cast(i, FlxBasic);
                    b.destroy();
                }
            }
            #end
            array.resize(0);
            return array;
        }
        return [];
    }

    #if flixel
    /**
     * Remove e destrói os itens de `FlxBasic` que não estão ativos ou não existem.
     *
     * Se a lista já estiver vazia, retorna uma nova `Array` vazia.
     *
     * @return A lista sem os itens inativos ou inexistentes, ou uma nova `Array` vazia
     * se a lista original já estivesse vazia.
     * @since 0.0.1
     */
    public inline static function removeDead<T:FlxBasic>(array:Array<T>):Array<T> {
        if (hasItems(array)) {
            for (i in array) {
                if (!i.alive || !i.exists) {
                    array.remove(i);
                    i.destroy();
                }
            }
            return array;
        }
        return [];
    }
    #end
}