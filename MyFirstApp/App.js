import React, { useState } from 'react';
import { StyleSheet, Text, View, TextInput, Pressable } from 'react-native';

export default function App() {
  const [name, setName] = useState('');
  const [count, setCount] = useState(0);

  return (
    <View style={styles.container}>
      <Text style={styles.title}>My First React Native App</Text>
      
      <TextInput
        style={styles.input}
        placeholder="Enter your name"
        value={name}
        onChangeText={setName}
      />
      
      <Text style={styles.greeting}>
        Hello, {name ? name : 'Guest'}!
      </Text>
      
      <Text style={styles.counterText}>
        {count}
      </Text>
      
      <View style={styles.buttonRow}>
        <Pressable 
          style={[styles.button, styles.increaseButton]} 
          onPress={() => setCount(count + 1)}
        >
          <Text style={styles.buttonText}>Increase</Text>
        </Pressable>
        
        <Pressable 
          style={[styles.button, styles.decreaseButton]} 
          onPress={() => setCount(count - 1)}
        >
          <Text style={styles.buttonText}>Decrease</Text>
        </Pressable>
      </View>
      
      <Pressable 
        style={[styles.button, styles.resetButton]} 
        onPress={() => setCount(0)}
      >
        <Text style={styles.buttonText}>Reset</Text>
      </Pressable>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
    padding: 20,
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 20,
  },
  input: {
    width: '100%',
    height: 50,
    borderColor: '#ccc',
    borderWidth: 1,
    borderRadius: 8,
    paddingHorizontal: 15,
    marginBottom: 20,
    fontSize: 16,
  },
  greeting: {
    fontSize: 20,
    marginBottom: 30,
  },
  counterText: {
    fontSize: 48,
    fontWeight: 'bold',
    marginBottom: 20,
  },
  buttonRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    width: '100%',
    marginBottom: 15,
  },
  button: {
    paddingVertical: 12,
    paddingHorizontal: 20,
    borderRadius: 8,
    alignItems: 'center',
    justifyContent: 'center',
  },
  increaseButton: {
    backgroundColor: '#4CAF50',
    flex: 1,
    marginRight: 10,
  },
  decreaseButton: {
    backgroundColor: '#F44336',
    flex: 1,
    marginLeft: 10,
  },
  resetButton: {
    backgroundColor: '#2196F3',
    width: '100%',
  },
  buttonText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: 'bold',
  },
});
