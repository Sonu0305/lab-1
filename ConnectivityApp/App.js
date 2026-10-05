import { useState, useEffect } from 'react';
import { StyleSheet, Text, View, Pressable, SafeAreaView } from 'react-native';
import NetInfo from '@react-native-community/netinfo';

export default function App() {
  const [netInfo, setNetInfo] = useState(null);

  useEffect(() => {
    // Subscribe to network state updates
    const unsubscribe = NetInfo.addEventListener(state => {
      setNetInfo(state);
    });

    // Cleanup subscription on unmount
    return () => {
      unsubscribe();
    };
  }, []);

  const handleRefresh = async () => {
    const state = await NetInfo.fetch();
    setNetInfo(state);
  };

  const isOnline = netInfo?.isConnected;

  return (
    <SafeAreaView style={styles.container}>
      {netInfo === null ? (
        <Text style={styles.loadingText}>Checking connection...</Text>
      ) : (
        <View style={styles.content}>
          <View
            style={[
              styles.statusBox,
              { backgroundColor: isOnline ? '#4caf50' : '#f44336' },
            ]}
          >
            <Text style={styles.statusText}>
              {isOnline ? 'Online' : 'Offline'}
            </Text>
          </View>

          <View style={styles.detailsContainer}>
            <Text style={styles.detailText}>
              <Text style={styles.boldText}>Type:</Text> {netInfo.type}
            </Text>
            <Text style={styles.detailText}>
              <Text style={styles.boldText}>Internet Reachable:</Text>{' '}
              {netInfo.isInternetReachable === true
                ? 'Yes'
                : netInfo.isInternetReachable === false
                ? 'No'
                : 'Unknown'}
            </Text>
          </View>

          <Pressable style={styles.refreshButton} onPress={handleRefresh}>
            <Text style={styles.refreshButtonText}>Check Now</Text>
          </Pressable>
        </View>
      )}
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
    alignItems: 'center',
    justifyContent: 'center',
  },
  content: {
    width: '90%',
    alignItems: 'center',
  },
  loadingText: {
    fontSize: 18,
    color: '#666',
  },
  statusBox: {
    width: '100%',
    paddingVertical: 30,
    borderRadius: 12,
    alignItems: 'center',
    marginBottom: 30,
    elevation: 4,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.2,
    shadowRadius: 4,
  },
  statusText: {
    fontSize: 32,
    fontWeight: 'bold',
    color: '#fff',
    textTransform: 'uppercase',
  },
  detailsContainer: {
    width: '100%',
    backgroundColor: '#fff',
    padding: 20,
    borderRadius: 12,
    marginBottom: 30,
    elevation: 2,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.1,
    shadowRadius: 2,
  },
  detailText: {
    fontSize: 18,
    color: '#333',
    marginBottom: 10,
  },
  boldText: {
    fontWeight: 'bold',
  },
  refreshButton: {
    backgroundColor: '#2196f3',
    paddingVertical: 15,
    paddingHorizontal: 40,
    borderRadius: 8,
    elevation: 3,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.2,
    shadowRadius: 3,
  },
  refreshButtonText: {
    color: '#fff',
    fontSize: 18,
    fontWeight: 'bold',
  },
});
